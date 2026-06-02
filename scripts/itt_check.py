"""
This script is a GitHub Actions PR validation check that verifies the last commit in a pull
request contains at least one valid ITT:[number] reference in the commit message. Only the
last commit is checked because PRs are merged via squash — the last commit message becomes
the squash commit message and must carry the ITT reference for audit traceability.

Business logic: this validation enforces traceability between code changes and internal
tracking tickets for audit/compliance purposes. Input: GitHub environment variables
(GITHUB_TOKEN, GITHUB_REPOSITORY, PR_NUMBER) and commit messages from the PR. Output:
validation logs in the GitHub Actions console and an exit code (0 for success, 1 for
failure), which determines whether the PR pipeline continues or is blocked.

Usage:
    python scripts/itt_check.py

Required environment variables (set automatically by GitHub Actions):
    GITHUB_TOKEN       - token with repo read access
    GITHUB_REPOSITORY  - "owner/repo"
    PR_NUMBER          - pull request number
"""

import os
import re
import sys
import json
import urllib.request
import urllib.error

# Matches ITT:[123] or ITT:[123, 456] anywhere in the commit message, case-insensitive
ITT_PATTERN = re.compile(r'(?i)ITT:\[(\d+(?:,\s*\d+)*)\]')


def github_request(url: str, token: str) -> dict:
    # Single GitHub REST API call — returns parsed JSON
    req = urllib.request.Request(
        url,
        headers={
            'Authorization': f'Bearer {token}',
            'Accept': 'application/vnd.github+json',
            'X-GitHub-Api-Version': '2022-11-28',
        },
    )
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())


def get_pr_commits(repo: str, pr_number: str, token: str) -> list:
    # GitHub returns max 100 commits per page — loop until we have them all
    commits = []
    page = 1
    while True:
        url = f'https://api.github.com/repos/{repo}/pulls/{pr_number}/commits?per_page=100&page={page}'
        page_data = github_request(url, token)
        if not page_data:
            break
        commits.extend(page_data)
        if len(page_data) < 100:  # last page
            break
        page += 1
    return commits


def extract_itt_numbers(message: str) -> list[int]:
    # Returns all ITT ticket numbers found in the message, e.g. [123, 456]
    numbers = []
    for match in ITT_PATTERN.finditer(message):
        for n in match.group(1).split(','):
            numbers.append(int(n.strip()))
    return numbers


def main():
    # Read env vars injected by GitHub Actions
    token = os.environ.get('GITHUB_TOKEN')
    repo = os.environ.get('SOURCE_REPO') or os.environ.get('GITHUB_REPOSITORY')
    pr_number = os.environ.get('PR_NUMBER')

    missing = [v for v, k in [('GITHUB_TOKEN', token), ('SOURCE_REPO', repo), ('PR_NUMBER', pr_number)] if not k]
    if missing:
        print(f'ERROR: missing environment variables: {", ".join(missing)}', file=sys.stderr)
        sys.exit(1)

    print(f'Checking ITT reference in last commit of PR #{pr_number} ({repo})')

    # Fetch all commits that belong to this PR
    try:
        commits = get_pr_commits(repo, pr_number, token)
    except urllib.error.HTTPError as e:
        print(f'ERROR: GitHub API request failed: {e.code} {e.reason}', file=sys.stderr)
        sys.exit(1)

    if not commits:
        print('ERROR: no commits found in PR', file=sys.stderr)
        sys.exit(1)

    print(f'Total commits in PR: {len(commits)} — checking last commit only (squash merge)')

    # Only the last commit is checked — it becomes the squash commit message on merge
    last = commits[-1]
    sha = last['sha']
    short_sha = sha[:8]
    message = last['commit']['message']
    itt_numbers = extract_itt_numbers(message)

    print(f'\nLast commit: {short_sha}')
    print(f'Message: {message.splitlines()[0][:80]}')

    if itt_numbers:
        print(f'\nPASSED  ITT tickets found: {itt_numbers}')
    else:
        print(f'\nFAILED  No ITT reference found in last commit {short_sha}')
        print(
            '\nFIX: amend the last commit to include ITT:[<number>] in the message body.'
            '\nExample: ITT:[123]  or  ITT:[123, 456]'
        )
        sys.exit(1)  # non-zero exit blocks the PR in GitHub Actions

    print('\nITT check passed.')


if __name__ == '__main__':
    main()

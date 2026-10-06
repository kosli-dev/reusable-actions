# reusable-actions
Reusable github actions

## send-slack-message

Posts a message to the Slack channel an incoming webhook belongs to.

| Input | Required | |
|---|---|---|
| `slack_url` | yes | Incoming-webhook URL, from a `SLACK_<CHANNEL>_WEBHOOK` org secret |
| `message` | yes | mrkdwn; split into several sections when over 3000 characters |
| `plain_text_preview` | no | Notification text; defaults to `title`, then `message` |
| `title` | no | Header above the message, cut to 150 characters |
| `color` | no | `success`, `failure`, `cancelled` (the values of `job.status`) or a hex colour |
| `footer` | no | Small mrkdwn line under the message |

```yaml
- uses: kosli-dev/reusable-actions/.github/actions/send-slack-message@main
  if: always()
  with:
    slack_url: ${{ secrets.SLACK_DEPLOYMENT_NOTIFICATIONS_WEBHOOK }}
    title: Staging deployment
    message: Deployed ${{ github.sha }}
    color: ${{ job.status }}
    footer: <${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}|Run>
```

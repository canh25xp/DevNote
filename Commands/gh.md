# gh

## Get notifications

```bash
gh api notifications           # Only unread
gh api notifications\?all=true # Get all
```

## Mark notifications as read

```bash
gh api -X PATCH /notifications/threads/19141841844
```

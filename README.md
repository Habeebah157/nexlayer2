# NexLayer2

This repository contains a simple test page for NexLayer and a GitHub Actions workflow to deploy it.

## Try the test page

Open `test_nexlayer.html` in a browser. For best results (avoiding CORS restrictions) serve the file with a local static server. Examples:

PowerShell (built-in):

```powershell
# Start a simple HTTP server from the repo root
python -m http.server 8000
# then open http://localhost:8000/test_nexlayer.html
```

Node (if you have http-server installed):

```powershell
npx http-server -p 8000
# then open http://localhost:8000/test_nexlayer.html
```

Notes:
- Change the Endpoint URL in the page to your NexLayer endpoint (for example, `http://localhost:8080/your-path`).
- If you still see CORS errors, configure NexLayer to allow the origin or run the browser with CORS disabled for local testing (not recommended for regular use).

## GitHub Actions deployment to Nexlayer

A workflow is included at `.github/workflows/deploy.yml`. It runs on pushes to `main` and calls the `scripts/deploy_nexlayer.sh` script which uploads a zip of the repo to the Nexlayer API.

To enable automatic deploys you need to add a repository secret containing your Nexlayer API token.

1. In your GitHub repo go to Settings -> Secrets and variables -> Actions -> New repository secret.
2. Name the secret: `NEXLAYER_TOKEN` (or update the workflow if you prefer a different name).
3. Paste your Nexlayer API token and save.

Once the secret is set, pushes to `main` will run the workflow and call the deploy script.

Notes:
- The included scripts use the example Nexlayer API endpoint `https://api.nexlayer.io/v1/deploy`. If your Nexlayer endpoint is different, edit `scripts/deploy_nexlayer.sh` and `scripts/deploy_nexlayer.ps1`.
- The scripts are simple examples for static sites. If you have a build step (Node build, bundler, etc.) update the workflow to run the build before the deploy step.
- The workflow and scripts do not expose your secret — keep it in GitHub Secrets.

If you'd like, I can also:
- Add a simple status check step that calls the Nexlayer deploy status endpoint and prints the final deployed URL.
- Update the workflow to run on pull request merges only or deploy from a different branch.

# NexLayer2

This repository contains a simple test page for NexLayer.

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
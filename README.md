Proof of concept, just for fun, to stream ChatGPT conversation chunks back to the client through Turbo Streams.

1. Ensure that PostgreSQL and Redis are running.
2. Create a ChatGPT API key and fund the account with a few dollars.
3. Create a Google OpenID client and populate the environment variables: GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET
4. Set DEVELOPMENT_EMAIL to your Google email

```
./bin/setup
./bin/dev
```

![Demo](docs/demo-35717613665832.gif)

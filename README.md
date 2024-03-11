# Turbo Chat

Proof of concept, just for fun, to stream ChatGPT conversation chunks back to the client through Turbo Streams.

1. Create a ChatGPT API key and fund the account with a few dollars
2. Create a Google OpenID client and populate the environment variables: GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET
3. Set DEVELOPMENT_EMAIL to your Google email
4. Visit `/logins/new` and sign in
5. Add your API key to `users/1/edit`

```
./bin/setup
./bin/dev
```

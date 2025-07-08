# Deployment Configuration

## Environment-Specific Configuration

This directory contains templates for environment-specific configuration. **NEVER** commit actual secrets to version control.

### Files

- `production.env.template` - Production environment template
- `staging.env.template` - Staging environment template

### Deployment Platforms

#### 1. Vercel Deployment

Set environment variables in Vercel dashboard:

```bash
# Production
EXTENDED_API_KEY=your_production_api_key
EXTENDED_VAULT_ID=your_production_vault_id
STARKNET_PRIVATE_KEY=0x_your_production_private_key
STARKNET_PUBLIC_KEY=0x_your_production_public_key
FLUTTER_ENV=production
APP_MODE=real
```

#### 2. Firebase Hosting

Use Firebase environment configuration:

```bash
firebase functions:config:set \
  extended.api_key="your_api_key" \
  extended.vault_id="your_vault_id" \
  starknet.private_key="0x_your_private_key" \
  starknet.public_key="0x_your_public_key"
```

#### 3. Docker Deployment

Create `.env.production` file (not in version control):

```bash
docker run -d \
  --env-file .env.production \
  your-app-image
```

#### 4. GitHub Actions

Set repository secrets:

```yaml
env:
  EXTENDED_API_KEY: ${{ secrets.EXTENDED_API_KEY }}
  EXTENDED_VAULT_ID: ${{ secrets.EXTENDED_VAULT_ID }}
  STARKNET_PRIVATE_KEY: ${{ secrets.STARKNET_PRIVATE_KEY }}
  STARKNET_PUBLIC_KEY: ${{ secrets.STARKNET_PUBLIC_KEY }}
```

### Security Best Practices

1. **Never commit secrets to version control**
2. **Use different credentials for each environment**
3. **Rotate credentials regularly**
4. **Use your platform's secret management system**
5. **Monitor secret access and usage**

### Local Development

For local development, copy `.env.template` to `.env` and fill in your development credentials.
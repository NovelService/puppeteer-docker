FROM alpine:3.15.0

# Installs latest Chromium (93) package.
# Specific version see: https://pkgs.alpinelinux.org/packages?name=&branch=v3.15
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      yarn

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
      PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Puppeteer v10.2.0 works with Chromium 93.
RUN yarn add puppeteer@10.2.0

# Add user so we don't need --no-sandbox.
RUN addgroup -S user && adduser -S -g user user \
      && mkdir -p /home/user/Downloads /app \
      && chown -R user:user /home/user \
      && chown -R user:user /app

# Run everything after as non-privileged user.
USER user

# Base this container on Node 6
FROM gitlab.e1c.net:4567/ops/base-images:node8


# Build arguments
ARG VERSION_NUMBER
ARG NPM_AUTH_TOKEN


# Ensure system is fully up-to-date
RUN apk update \
 && rm -rf /var/cache/apk/*


# Create a non-root user for running the service
RUN adduser -S service

# Set where the service will be installed
WORKDIR /opt/service

# Install application dependencies
COPY package.json ./
# RUN npm set registry https://npm.e1c.net/ \
#  && npm set //npm.e1c.net/:_authToken="$NPM_AUTH_TOKEN" \
#  && npm install --prod --verbose

# Make dir that can be mounted with DB entry file(s)
# RUN mkdir -p /tmp/mfa-service/db-entries
# RUN chown -R service: /tmp/mfa-service/db-entries

# Place the application code itself
# COPY common common
# COPY env env
COPY server server

# Insert the version number
# RUN sed -i "s|\"version\": \".*\"|\"version\": \"$VERSION_NUMBER\"|" package.json


# Execute the service as a particular user
EXPOSE 6000
USER service
CMD [ "npm", "run", "container" ]

# ~~~ BUILDER

FROM debian:bookworm-slim as build

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /build

# Update package lists and install necessary tools
RUN apt-get update && apt-get install -y wget tar apt-utils
RUN rm -rf /var/lib/apt/lists/*

# Download and install NoIP DUC
RUN wget https://dmej8g5cpdyqd.cloudfront.net/downloads/noip-duc_3.0.0-beta.7.tar.gz \
    && tar xf noip-duc_3.0.0-beta.7.tar.gz
RUN apt-get install -y ./noip-duc_3.0.0-beta.7/binaries/noip-duc_3.0.0-beta.7_amd64.deb 

# Cleanup
RUN rm -rf /build/* \
  && apt-get autoremove -y \
  && apt-get clean

CMD noip-duc -g $DUC_GROUP -u $DUC_USERNAME -p $DUC_PASSWORD
# CMD ["noip-duc", "-g", "$DUC_GROUP", "-u", "$DUC_USERNAME", "-p", "$DUC_PASSWORD"]

# # ~~~ RUNTIME

# # distroless runtime image
# FROM gcr.io/distroless/static-debian12

# COPY --from=build /usr/bin/noip-duc /usr/bin/

# CMD ["/usr/bin/noip-duc", "-g", "$DUC_GROUP", "-u", "$DUC_USERNAME", "-p", "$DUC_PASSWORD"]
FROM golang:1.16-alpine
MAINTAINER Atsushi Nagase <a@ngs.io> (https://ngs.io)

LABEL "com.github.actions.name"="Go Release Binary"
LABEL "com.github.actions.description"="Automate publishing Go build artifacts for GitHub releases"
LABEL "com.github.actions.icon"="cpu"
LABEL "com.github.actions.color"="orange"

LABEL "name"="Automate publishing Go build artifacts for GitHub releases through GitHub Actions"
LABEL "version"="1.0.2"
LABEL "repository"="http://github.com/spetr/go-release.action"

LABEL "maintainer"="Stanislav Petr <stanislav@petr.email>"

RUN apk add --no-cache curl jq git build-base bash zip

ADD entrypoint.sh /entrypoint.sh
ADD build.sh /build.sh
ENTRYPOINT ["/entrypoint.sh"]

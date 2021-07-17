FROM golang:1.16-alpine

LABEL "name"="Automate publishing Go build artifacts for GitHub releases through GitHub Actions"
LABEL "version"="1.0.3"
LABEL "repository"="http://github.com/spetr/go-release.action"
LABEL "maintainer"="Stanislav Petr <stanislav@petr.email>"

LABEL "com.github.actions.name"="Go Release Binary"
LABEL "com.github.actions.description"="Automate publishing Go build artifacts for GitHub releases"
LABEL "com.github.actions.icon"="cpu"
LABEL "com.github.actions.color"="orange"

RUN apk add --no-cache curl jq git build-base bash zip

ADD entrypoint.sh build.sh /

ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:24.04

ARG UID
ARG GUID
ARG RUN_AS

USER root

# needed to accept steam EULA
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y dotnet-sdk-10.0 wget unzip

RUN groupadd -g ${GUID} -o ${RUN_AS}
RUN useradd -m -u ${UID} -g ${GUID} -o -s /bin/bash ${RUN_AS}

RUN mkdir -p /home/${RUN_AS}/data && \
    chown -hR ${RUN_AS}:${RUN_AS} /home/${RUN_AS}/

USER ${RUN_AS}

COPY --chown=${RUN_AS} entrypoint.sh /home/${RUN_AS}/server/
COPY --chown=${RUN_AS} server_config.toml /home/${RUN_AS}/server/

RUN chmod +x /home/${RUN_AS}/server/entrypoint.sh

WORKDIR /home/${RUN_AS}/server

ENTRYPOINT [ "./entrypoint.sh" ]
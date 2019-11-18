#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
FROM debian:10

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN addgroup -S app && adduser -S app -G app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles
RUN mkdir $APP_HOME/mediafiles
WORKDIR $APP_HOME


# Geodjango packages
RUN apt-get -y install gdal-bin \
  python3 \
  python3-dev \
  libgdal-dev \
  binutils \
  wget \
  curl \
  python3-venv \
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y


# Get pip and poetry
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py && pip install poetry


# make some useful symlinks that are expected to exist
RUN cd /usr/bin \
  && { [ -e easy_install ] || ln -s easy_install-* easy_install; } \
  && ln -s idle3 idle \
  && ln -s pydoc3 pydoc \
  && ln -s python3 python \
  && ln -s python3-config python-config

# copy project
COPY . ${APP_HOME}

RUN poetry install

# copy entrypoint.sh
COPY ./entrypoint.sh ${APP_HOME}

# chown all the files to the app user
RUN chown -R app:app $APP_HOME
# change to the app user
USER app

# run entrypoint.prod.sh
ENTRYPOINT ["/home/app/web/entrypoint.sh"]
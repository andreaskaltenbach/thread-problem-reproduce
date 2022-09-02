FROM python:3.6-buster AS base
WORKDIR /app
COPY requirements.txt /app/
RUN pip install pip-tools start && \
    pip install --requirement requirements.txt
    
ENV LC_ALL=C.UTF-8 \
    NVM_DIR=/opt/nvm \
    PATH=/root/.local/bin:$PATH \
    PIP_REQUIRE_VIRTUALENV=false \
    PROCFILE_PATH=/app/Procfile \
    PYTHONUNBUFFERED=1 \
# Attempt to resolve problem with memory-stream downloads
    UWSGI_WSGI_DISABLE_FILE_WRAPPER=''

FROM base
COPY . /app
CMD ["start", "web"]

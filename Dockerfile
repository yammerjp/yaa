FROM python:3.12
# TODO use alpine and install packages

# Don't run as root
RUN adduser --disabled-password app && \
    # Set the working directory in the container
    mkdir -p /home/app/yaa && \
    chown app:app /home/app/yaa && \
    # Use wget instead of curl since curl is external package in alpine
    # https://python-poetry.org/docs/#installation
    wget -O get-poetry.py https://install.python-poetry.org && \
    POETRY_HOME=/home/app/.poetry python3 get-poetry.py && \
    rm get-poetry.py

RUN curl -L --output - 'https://github.com/sqldef/sqldef/releases/latest/download/psqldef_linux_amd64.tar.gz' | tar xvz && mv psqldef /usr/local/bin/psqldef && chmod 755 /usr/local/bin/psqldef

USER app

# Add Poetry to PATH
ENV PATH="/home/app/.poetry/bin:${PATH}"

WORKDIR /home/app/yaa

# Install dependencies
COPY poetry.lock pyproject.toml ./
COPY README.md ./
COPY yaa/__init__.py ./yaa/__init__.py
RUN poetry install

# Copy the rest of your application into the Docker image
COPY ./ /home/app/yaa

CMD ["poetry", "run", "uvicorn", "yaa.main:app", "--host", "0.0.0.0", "--port", "80"]

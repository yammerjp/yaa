FROM python:3.12

ENV PATH /root/.local/bin:$PATH

RUN apt-get update \
  && curl -sSL https://install.python-poetry.org | python - \
  && poetry config virtualenvs.create false

WORKDIR /app
COPY ./pyproject.toml .
COPY ./poetry.lock .
COPY ./README.md .
RUN mkdir yaa
COPY ./yaa/__init__.py ./yaa
RUN poetry install
COPY . .

EXPOSE 80
CMD ["poetry", "run", "uvicorn", "yaa.main:app", "--host", "0.0.0.0", "--port", "80"]

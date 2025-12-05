# ---------- Stage 1: Builder ----------
FROM python:3.11-slim AS builder
WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt


# ---------- Stage 2: Runtime ----------
FROM python:3.11-slim
WORKDIR /app
ENV TZ=UTC

COPY --from=builder /install /usr/local
COPY . /app

EXPOSE 8080

# Run FastAPI server
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port 8080"]



FROM alpine:3.21.4

RUN apk add --no-cache python3 py3-pip py3-virtualenv

WORKDIR /app

COPY website/ .

# Create and activate a virtual environment, then install Flask inside it
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]


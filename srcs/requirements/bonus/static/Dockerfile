FROM alpine:3.21.4

EXPOSE 5000

RUN apk add --no-cache \
	python3 \
	py3-pip \
	py3-virtualenv \
	build-base # gunicorn dependencies

RUN addgroup flask && adduser -S flask -G flask

WORKDIR /app

COPY --chown=flask:flask website/ .

# Create and activate a virtual environment, then install Flask inside it
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir -r requirements.txt && \
	pip install --no-cache-dir gunicorn

# Security
USER flask

# Launch gunicorn with 4 workers on port 5000
# "app:app" = file 'app.py' and variable 'app = Flask(...)'
ENTRYPOINT ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]


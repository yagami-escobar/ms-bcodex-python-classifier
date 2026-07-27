FROM python:3.12-slim

# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE=1
# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1


WORKDIR /app

COPY requirements.txt .

RUN apt update \
 && apt install -y --no-install-recommends gcc libc-dev curl vim iputils-ping iproute2 net-tools lsof procps\
 && pip install --no-cache-dir -r requirements.txt \
 && apt remove -y gcc libc-dev \
 && apt autoremove -y \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*


COPY . .

# Train the model
RUN python model/train.py

EXPOSE 6000

CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:6000", "--access-logfile", "-","--error-logfile", "-", "app:app"]
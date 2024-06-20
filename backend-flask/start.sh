# Set the Flask environment
export FLASK_ENV=${FLASK_ENV}

# Run the Flask application
exec python3 -m flask run --host=0.0.0.0 --port=${PORT}
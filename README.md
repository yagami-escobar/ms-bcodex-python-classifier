# Intent Classifier Model

This small project demostrates:
- Training a tiny text classifier
- Saving the model artifact
- Serving predictions via Flask API (/predict)

# Quick Start (local)

1. Create a virtualenv and install: 
    ```
    python3 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install -r requirements.txt
    ```
2. Train the model: This will create model/artifacts/intent_model.pkl
    ```
    python3 model/train.py
    ```

3. Run the API: The API will be available at http://127.0.0.1:6000
    ```
    python3 app.py
    ```

4. Execute Request:
    ```
    curl -X POST http://127.0.0.1:6000/predict
    -H "Content-Type: application/json"
    -d '{"text": "I want to cancel my subscription"}'
    ```

    ```Response: {"intent":"complaint", "probabilities":{"complaint": 0.85, "question": 0.05, ...}}```
# tts_module.py
import pyttsx3

# Initialize the TTS engine once
engine = pyttsx3.init()
engine.setProperty('rate', 150)  # Speed of speech
engine.setProperty('volume', 1.0)  # Volume (0.0 to 1.0)

def speak(text):
    """Convert the given text to speech."""
    if text:
        engine.say(text)
        engine.runAndWait()

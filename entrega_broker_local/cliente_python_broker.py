"""Cliente MQTT em Python para publicar uma mensagem em um broker local.

Instalação da dependência:
    python -m pip install paho-mqtt

Execução:
    python cliente_python_broker.py
"""

import os

import paho.mqtt.client as mqtt

# Substitua pelo nome do aluno solicitado na atividade ou defina a variável
# de ambiente NOME_ALUNO antes de executar o programa.
NOME_ALUNO = os.getenv("NOME_ALUNO", "NOME DO ALUNO")
BROKER_HOST = os.getenv("BROKER_HOST", "localhost")
BROKER_PORT = int(os.getenv("BROKER_PORT", "1883"))
BROKER_USUARIO = os.getenv("BROKER_USUARIO")
BROKER_SENHA = os.getenv("BROKER_SENHA")

# Requisito da atividade: o tópico deve conter o nome do aluno.
TOPICO = NOME_ALUNO
MENSAGEM = "Comunicando com o servidor broker local"


def main() -> None:
    """Conecta ao broker, publica a mensagem e encerra a conexão."""
    cliente = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)

    if BROKER_USUARIO:
        cliente.username_pw_set(BROKER_USUARIO, BROKER_SENHA or "")

    print(f"Conectando a {BROKER_HOST}:{BROKER_PORT}...")
    cliente.connect(BROKER_HOST, BROKER_PORT, keepalive=60)

    resultado = cliente.publish(TOPICO, MENSAGEM, qos=0, retain=False)
    resultado.wait_for_publish()

    if resultado.rc != mqtt.MQTT_ERR_SUCCESS:
        raise RuntimeError(f"Falha ao publicar a mensagem. Código MQTT: {resultado.rc}")

    print(f"Mensagem publicada no tópico {TOPICO!r}: {MENSAGEM!r}")
    cliente.disconnect()


if __name__ == "__main__":
    main()

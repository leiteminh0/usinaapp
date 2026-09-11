"""ESP32 + MicroPython: publica uma mensagem JSON em um broker MQTT.

Biblioteca necessária no dispositivo:
    umqtt.simple

Ajuste WIFI_SSID, WIFI_SENHA, BROKER_HOST e NOME_ALUNO antes de gravar
este arquivo no ESP32.
"""

import json
import time

import network
from umqtt.simple import MQTTClient

WIFI_SSID = "NOME_DA_REDE_WIFI"
WIFI_SENHA = "SENHA_DA_REDE_WIFI"
BROKER_HOST = "192.168.1.100"  # IP do computador que executa o broker
BROKER_PORTA = 1883
BROKER_USUARIO = None  # Ex.: "usuario"
BROKER_SENHA = None  # Ex.: "senha"
NOME_ALUNO = "NOME DO ALUNO"
CLIENT_ID = b"esp32-aluno"
TOPICO = NOME_ALUNO.encode("utf-8")


def conectar_wifi():
    """Conecta o ESP32 à rede Wi-Fi configurada."""
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)

    if not wlan.isconnected():
        print("Conectando ao Wi-Fi...")
        wlan.connect(WIFI_SSID, WIFI_SENHA)
        tentativas = 0
        while not wlan.isconnected() and tentativas < 30:
            time.sleep(1)
            tentativas += 1

    if not wlan.isconnected():
        raise RuntimeError("Não foi possível conectar ao Wi-Fi")

    print("Wi-Fi conectado:", wlan.ifconfig())
    return wlan


def main():
    conectar_wifi()

    cliente = MQTTClient(
        CLIENT_ID,
        BROKER_HOST,
        port=BROKER_PORTA,
        user=BROKER_USUARIO,
        password=BROKER_SENHA,
        keepalive=60,
    )
    cliente.connect()

    # json.dumps garante a serialização no padrão JSON.
    dados = {
        "msg": "IoT com ESP32",
        "valor_int": 10,
        "valor_dec": 10.5,
    }
    payload = json.dumps(dados)
    cliente.publish(TOPICO, payload.encode("utf-8"))

    print("JSON publicado no tópico {}: {}".format(TOPICO.decode(), payload))
    cliente.disconnect()


if __name__ == "__main__":
    main()

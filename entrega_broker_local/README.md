# Entrega — Comunicação com servidor broker local

Esta pasta contém os dois códigos solicitados para publicação MQTT em um servidor broker local.

| Item | Arquivo | Plataforma | Conteúdo publicado |
|---|---|---|---|
| 01 | `cliente_python_broker.py` | Computador com Python | Texto simples no tópico com o nome do aluno |
| 02 | `esp32_micropython_mqtt.py` | ESP32 com MicroPython | Objeto JSON com texto, inteiro e decimal |

## 1. Cliente Python

O programa usa a biblioteca `paho-mqtt`. Instale a dependência com:

```bash
python -m pip install paho-mqtt
```

Antes de executar, informe o nome do aluno. O tópico da mensagem será exatamente esse nome:

```bash
export NOME_ALUNO="Seu Nome"
export BROKER_HOST="localhost"
export BROKER_PORT="1883"
python cliente_python_broker.py
```

A mensagem publicada será:

```text
Tópico: Seu Nome
Mensagem: Comunicando com o servidor broker local
```

Se o broker exigir autenticação, também podem ser definidas as variáveis `BROKER_USUARIO` e `BROKER_SENHA`.

## 2. ESP32 com MicroPython

Edite no início de `esp32_micropython_mqtt.py` as constantes `WIFI_SSID`, `WIFI_SENHA`, `BROKER_HOST` e `NOME_ALUNO`. O `BROKER_HOST` deve ser o endereço IP do computador que executa o broker. Em uma rede local, não use `localhost` no ESP32, porque esse endereço aponta para o próprio ESP32.

Transfira o arquivo para o ESP32 usando `mpremote`, Thonny ou outra ferramenta compatível. O dispositivo precisa ter o módulo `umqtt.simple` instalado. Depois, execute o arquivo no ESP32.

O payload publicado pelo ESP32 é serializado como JSON:

```json
{"msg": "IoT com ESP32", "valor_int": 10, "valor_dec": 10.5}
```

O tópico usado pelo ESP32 também é o nome definido em `NOME_ALUNO`.

## Teste do broker

Com Mosquitto instalado, um terminal pode acompanhar as mensagens:

```bash
mosquitto_sub -h localhost -t "Seu Nome" -v
```

Em outro terminal, execute o cliente Python. Para testar o ESP32, substitua `localhost` pelo IP do computador na configuração do assinante quando necessário.

## Observações

O broker deve estar em execução antes dos clientes. A porta MQTT sem TLS normalmente é `1883`. O código publica uma única mensagem e encerra a conexão, o que atende ao envio solicitado na atividade.

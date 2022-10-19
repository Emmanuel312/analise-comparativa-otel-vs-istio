import matplotlib
import matplotlib.pyplot as plt
import numpy as np


def labelsFactory(amount = 8):
    labels = []
    for i in range(amount):
        labels.append(f'#{i + 1}')

    return labels

def chartFactory(istio_data, otel_data, yLabel, title):
    labels = labelsFactory()
    x = np.arange(len(labels))  # the label locations
    width = 0.35  # the width of the bars
    
    fig, ax = plt.subplots()
    rects1 = ax.bar(x - width/1.5, istio_data, width, label='Istio', color = ['#516baa'])
    rects2 = ax.bar(x + width/2, otel_data, width, label='OpenTelemetry', color = ['#f5a800'])
    
    ax.set_ylabel(yLabel, weight = 'bold', fontsize = 16)
    ax.set_xlabel('experimento', weight = 'bold', fontsize = 16)

    ax.set_title(title, weight = 'bold', fontsize = 16)
    ax.set_xticks(x, labels, fontsize = 16)
    ax.legend()

    ax.bar_label(rects1, padding=3)
    ax.bar_label(rects2, padding=3)

    fig.tight_layout()

    plt.show()


def convert_to_kbyte(data):
    converted_data = []
    for i in data:
        converted_data.append(i / 1024)

    return converted_data

def main():
    istio_m1_data = [656, 73, 47.5, 756, 711, 37.3, 35.4, 48.7]
    istio_m2_data = convert_to_kbyte([515907584, 333783040, 327761920, 516341760, 460857344, 320106496, 362663936, 331972608])
    istio_m3_data = convert_to_kbyte([122272.193, 129661.126, 121926.236, 162323.964, 111592.882, 220113.543, 190554.569, 135582.821])  

    otel_m1_data = [53.8, 35.5, 38, 63.3 , 53.1, 35.5, 38.1, 34.2]
    otel_m2_data = convert_to_kbyte([498901696, 404528960, 421135552, 520428416, 500500800, 427134976, 446198400, 423976960])
    otel_m3_data = convert_to_kbyte([85442.793, 107844.333, 95325.894, 130173.752, 62398.931, 172548.735, 117680.306, 123430.666])

    font = {'family' : 'normal',
        'weight' : 'bold',
        'size'   : 13}

    matplotlib.rc('font', **font)

    chartFactory(istio_m1_data, otel_m1_data, "Milicores", "Uso de CPU dos sidecars de monitoramento")
    chartFactory(istio_m2_data, otel_m2_data, "KB", "Uso de memória dos sidecars de monitoramento")
    chartFactory(istio_m3_data, otel_m3_data, "KB/s", "Taxa de uso de rede")

if __name__ == "__main__":
    main()
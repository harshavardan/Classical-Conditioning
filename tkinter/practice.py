import tkinter as tk

def show_parameters():
    for i in range(0, len(fields)):
            print(parameters[i].get())

fields = ["Fish id:", "Genotype:", "Age:", "CS duration (s):", "US duration (s):", "ISI:",
        "Initial delay (s):", "Max. ITI (s):", "Min. ITI (s):", "Pre training CS trials:", 
        "Pre training US trials:", "Training trials:", "Probe trials"]
parameters = []

master = tk.Tk()
master.title("Classical Conditioning")

x = 0
y = 0

for i in range(0, len(fields)):
    tk.Label(master, text = fields[i]).grid(row = x, column = y)
    x += 1
    if i % 5 == 0:
        x = 0
        y += 2

x = 0
y = 1

for i in range(0, len(fields)):
    parameters.append(tk.Entry(master))
    parameters[i].grid(row = x, column = y)
    x += 1
    if i % 5 == 0:
        x = 0
        y += 2


tk.Button(master, text = "Quit", command = master.quit).grid(row = 10, column = 0)
tk.Button(master, text = "Run", command = show_parameters).grid(row = 10, column = 1)

tk.mainloop()

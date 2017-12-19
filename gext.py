from tkinter import *
from tkinter import ttk

def calc(event):
    dict = {}
    dict["2"] = ["04-8240", -3]
    dict["3"] = ["04-8249", -3]
    dict["70"] = ["04-82807", -2]
    dict["71"] = ["04-66479", -2]
    dict["8"] = ["04-8288", -3]

    strVarLbl.set("04-???????")
    ext = strVarEntry.get()

    if len(ext) == 4:
        for key in dict:
            if ext.startswith(key):
                full_number = dict[key][0] + ext[dict[key][1]:]
                strVarLbl.set(full_number)



root = Tk()
root.title("Phone Calculator")
root.geometry("400x40+100+100")
root.resizable(width=False, height=False)
root.bind('<Return>', calc)

strVarLbl = StringVar()
strVarLbl.set("04-???????")

strVarEntry = StringVar()

Entry(root, width=20, textvariable=strVarEntry).grid(row=0, column=0,  padx=2, pady=4, sticky=W)
btn = Button(root, text="Calculate")
btn.grid(row=0, column=1, padx=8, pady=4)
btn.bind("<Button-1>", calc)


Label(root, width=20, textvariable=strVarLbl).grid(row=0, column=2, padx=2, pady=4, sticky=E)



root.mainloop()

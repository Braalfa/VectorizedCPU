import pandas as pd

df = pd.read_csv("Control.csv")


for i in range(df.shape[0]):
    print("     4'b"+bin(i)[2:]+":begin")
    print("         useScalarAluED = 1'b" + str(df["useScalarAlu"][i]) + ";")
    print("         isScalarOutputED = 1'b" + str(df["isScalarOutput"][i]) + ";")
    print("         isScalarReg1ED = 1'b" + str(df["isScalarReg1"][i]) + ";")
    print("         isScalarReg2ED = 1'b" + str(df["isScalarReg2"][i]) + ";")
    print("         resultSelectorWBD = 1'b" + str(df["resultSelectorWBD"][i]) + ";")
    print("         writeEnableScalarWBD = 1'b" + str(df["writeEnableScalarWBD"][i]) + ";")
    print("         writeEnableVectorWBD = 1'b" + str(df["writeEnableVectorWBD"][i]) + ";")
    print("         writeToMemoryEnableMD = 1'b" + str(df["writeToMemoryEnableMD"][i]) + ";")
    print("         useInmediateED = 1'b" +str(df["useInmediateED"][i]) + ";")
    print("         aluControlED = 3'b" +str(df["aluControlED"][i]) + ";")
    print("         outFlagMD = 1'b" + str(df["outFlag"][i]) + ";")
    print("     end\n")
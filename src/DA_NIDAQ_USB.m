function DA_NIDAQ_USB(vector_voltios)

global Sesion

outputSingleScan(Sesion,max(min(10,vector_voltios),-10));
 
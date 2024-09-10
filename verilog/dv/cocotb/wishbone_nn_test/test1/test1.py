from caravel_cocotb.caravel_interfaces import test_configure
from caravel_cocotb.caravel_interfaces import report_test
from caravel_cocotb.caravel_interfaces import UART
from caravel_cocotb.caravel_interfaces import SPI
import cocotb

@cocotb.test() # decorator to mark the test function as cocotb test
@report_test # wrapper for configure test reporting files
async def test1(dut):
    caravelEnv = await test_configure(dut) #configure, start up and reset Caravel
    cocotb.log.info(f"[TEST] Start counter_wb test")  
    # wait for start of sending
    await caravelEnv.release_csb()
    await caravelEnv.wait_mgmt_gpio(1)
    cocotb.log.info(f"[TEST] finish configuration") 
    overwrite_val = 7 # value will be written to the counter by wishbone 
    # expect value bigger than 7 
    received_val = int ((caravelEnv.monitor_gpio(37,30).binstr + caravelEnv.monitor_gpio(7,0).binstr ),2)  
    counter = received_val
    await cocotb.triggers.ClockCycles(caravelEnv.clk,1)

    while True: # wait until the value 1 start counting after the initial
        received_val = int ((caravelEnv.monitor_gpio(37,30).binstr + caravelEnv.monitor_gpio(7,0).binstr ),2)  
        if counter == 0xFFFF: # rollover 
            counter = 0
        else: 
            counter +=1
        if received_val != counter: 
            if received_val == overwrite_val: 
                counter = received_val +1
                cocotb.log.info(f"Counter value has been overwritten by wishbone to be {received_val}")
                while True: #wait until the wishbone writing finished and the counter start running again
                    received_val = int ((caravelEnv.monitor_gpio(37,30).binstr + caravelEnv.monitor_gpio(7,0).binstr ),2)  
                    if counter == received_val: 
                        break
                    await cocotb.triggers.ClockCycles(caravelEnv.clk,1)
                cocotb.log.info(f"Counter value has been overwritten by wishbone to be {received_val}")
                break
            else: 
                cocotb.log.error(f"Counter has wrong value before overwrite happened expected: {counter} received: {received_val}")
        await cocotb.triggers.ClockCycles(caravelEnv.clk,1)

    for i in range(100):
        if counter != int ((caravelEnv.monitor_gpio(37,30).binstr + caravelEnv.monitor_gpio(7,0).binstr ),2) :
            cocotb.log.error(f"Counter have wrong value expected = {counter} recieved = {int ((caravelEnv.monitor_gpio(37,30).binstr + caravelEnv.monitor_gpio(7,0).binstr ),2) }")
        await cocotb.triggers.ClockCycles(caravelEnv.clk,1)
        counter +=1
    ######################## add test sequence ######################

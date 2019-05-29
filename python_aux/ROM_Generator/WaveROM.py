import math as mt

class WaveROM:
    def __init__():
        pass

    # ===============================================================
    # ---------------------------------------------------------------
    # File
    @staticmethod
    def touch_file(file_name):
        try:
            file = open(file_name, "r+")
        except FileNotFoundError:
            file = open(file_name, "w+")

        file.close()

    @staticmethod
    def overwrite_file(file_name):
        file = open(file_name, "w+")

        file.close()

    # ===============================================================
    # ---------------------------------------------------------------
    # PACKAGE
    @staticmethod
    def write_header_package(file_name = "waveROM_package.vhd"):
        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")  
        
        pkg_name = file_name.split(".")[0]

        # ---------------------------------------------------------------
        data = 'package '+ pkg_name + ' is\n' 
        file.write(data)

        file.close()

    @staticmethod
    def write_body_package(file_name = "waveROM_package.vhd"):
        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!") 
        
        pkg_name = file_name.split(".")[0]

        # ---------------------------------------------------------------
        data = 'package body '+ pkg_name + ' is\n' 
        file.write(data)

        file.close()

    # ===============================================================
    # ---------------------------------------------------------------
    # ROM32n
    @staticmethod
    def write_entity_wave_rom32n(file_name = 'wave_rom32n.vhd',
                                 N = 1024):
        
        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        pkg_name = file_name.split(".")[0]

        # ---------------------------------------------------------------
        data = 'entity wave_rom32n is\n'
        file.write(data)
        data = '\tport (\n'
        file.write(data)
        data = '\t\tCLOCK: in std_logic;'
        file.write(data)
        data = '\n\t\tADDRESS: in integer  range 0 to '+str(N-1)+';'
        file.write(data)
        data = '\n\t\tQ: out std_logic_vector (31 downto 0)\n'
        file.write(data)
        data = '\t);\n'
        file.write(data)
        data = 'end entity;\n\n'
        file.write(data)

        file.close()

    @staticmethod
    def write_architecture_wave_rom32n(file_name = 'wave_rom32n.vhd',
                                       N = 1024):
        
        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        pkg_name = file_name.split(".")[0]

        # ---------------------------------------------------------------
        data = 'architecture rtl of wave_rom32n is\n'
        file.write(data)
        data = 'begin\n'
        file.write(data)
        data = '\tprocess(CLOCK)\n'
        file.write(data)
        data = '\tbegin\n'
        file.write(data)
        data = '\t\tif CLOCK\'event and CLOCK = \'1\' then\n'
        file.write(data)
        data = '\t\t\tQ <= rom_core(ADDRESS);\n'
        file.write(data)
        data = '\t\tend if;\n'
        file.write(data)
        data = '\tend process;\n'
        file.write(data)

        file.close()

    # ===============================================================
    # ---------------------------------------------------------------
    # MISCELLANEOUS  
    @staticmethod
    def integer2logic_vector(input_integer,
                             bit_depth = 32):
  
        return format(input_integer, '032b')

    @staticmethod
    def write_basic_ieee(file_name):
        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        # ---------------------------------------------------------------
        data = 'library ieee;\nuse ieee.std_logic_1164.all;\nuse ieee.numeric_std.all;\n\n'
        file.write(data)

        file.close() 

    @staticmethod
    def write_use_package(file_name,
                          package_name):
        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        pkg_name = file_name.split(".")[0]

        # ---------------------------------------------------------------
        data = 'use work.'+package_name+'.all;\n\n'
        file.write(data)

        file.close() 

    @staticmethod
    def write_wave_type(file_name,
                        N = 1024,
                        bit_depth = 32):

        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        # ---------------------------------------------------------------
        data = '\t' + 'type wave_rom_logic_vector_array is array (' + str(N-1) + ' downto 0) of std_logic_vector ('+ str(bit_depth-1) + ' downto 0);'+'\n'
        file.write(data)
        data = '\t' + 'type wave_rom_unsigned_array is array (' + str(N-1) + ' downto 0) of Unsigned ('+ str(bit_depth-1) + ' downto 0);'+'\n\n'
        file.write(data)

        file.close()   

    @staticmethod
    def write_sin_wave_signal(file_name,
                              N = 1024,
                              bit_depth = 32,
                              pi = 3.1415926535897):

        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        # ---------------------------------------------------------------
        data = '\t'+'signal rom_core: wave_rom_logic_vector_array:=(' + '\n'
        file.write(data)

        for i in range(N-1):

            data = '\t\t' + str(i) + '\t => \"' + str(WaveROM.integer2logic_vector(int((2**bit_depth)/2 * mt.sin(i*(pi/(2*N)))))) + '\",\n'
            file.write(data)

        i =+ N-1;
        data = '\t\t' + str(N-1) + '\t => \"' + str(WaveROM.integer2logic_vector(int((2**bit_depth)/2 * mt.sin(i*(pi/(2*N)))))) + '\");\n\n'
        file.write(data)

        file.close()


    @staticmethod
    def write_end(file_name, pkg_name=None):

        try:
            file = open(file_name, "a")
        except FileNotFoundError:
            print("File not Found!")

        if pkg_name is None:
            data = 'end;\n\n'
        else:
            pkg_name = file_name.split(".")[0]
            data = 'end ' + pkg_name + ';\n\n'
        file.write(data)

        file.close()

# ===============================================================
# **************************************************************
# **************************************************************

if __name__ == '__main__':
    WaveROM.overwrite_file("wave_rom_package.vhd")
    WaveROM.write_basic_ieee("wave_rom_package.vhd")
    WaveROM.write_header_package("wave_rom_package.vhd")
    WaveROM.write_wave_type("wave_rom_package.vhd")
    WaveROM.write_sin_wave_signal("wave_rom_package.vhd")
    WaveROM.write_end("wave_rom_package.vhd", pkg_name=True)

    WaveROM.overwrite_file("wave_rom32n.vhd")
    WaveROM.write_basic_ieee("wave_rom32n.vhd")
    WaveROM.write_use_package("wave_rom32n.vhd", "waveROM_package")
    WaveROM.write_entity_wave_rom32n("wave_rom32n.vhd")
    WaveROM.write_architecture_wave_rom32n("wave_rom32n.vhd")
    WaveROM.write_end("wave_rom32n.vhd")
inplace fft의 verilog 코드모음

# 폴더

    -inplace_fft_dif_dpsram_r2_1stage
        * fft       : Inplace FFT
        * algorithm : DIF
        * point     : 64 pt
        * memory    : dual-port SRAM
        * Radix     : radix-2
        * addressing: vertex coloring
        * ping-pong : no
        * pipeline  : 1 stage
        * latency   : 225


    -inplace_fft_dif_dpsram_r2_2stage
        * fft       : Inplace FFT
        * algorithm : DIF
        * point     : 64 pt
        * memory    : dual-port SRAM
        * Radix     : radix-2
        * addressing: vertex coloring
        * ping-pong : no
        * pipeline  : 2 stage
        * latency   : 226


    -inplace_fft_dif_dpsram_r2_3stage
        * fft       : Inplace FFT
        * algorithm : DIF
        * point     : 64 pt
        * memory    : dual-port SRAM
        * Radix     : radix-2
        * addressing: vertex coloring
        * ping-pong : no
        * pipeline  : 3 stage
        * latency   : 227

    -inplace_fft_dif_dpsram_uhd_r2_1stage(tsmc)
        * fft       : Inplace FFT
        * algorithm : DIF
        * point     : 64 pt
        * memory    : dual-port ultra high density  SRAM (tsmc)
        * Radix     : radix-2
        * addressing: vertex coloring
        * ping-pong : no
        * pipeline  : 1 stage
        * latency   : 225

    -이전버전 : 이전의 verilog코드 모음 구조와 알고리즘은 "inplace_fft_dif_dpsram_r2_1stage"와 동일
        -mb_fft                                     : 출력이 제대로 나오지 않는 초기 버전
        -mb_fft_v2(no_input_reg)                    : 입력 register를 지우고 control 수정
        -mb_fft_v3                                  : control block을 FSM으로 설계
        -mb_fft_v3_sat                              : overflow로 인한 손해를 없애기 위해 saturation으로 처리
        -mb_fft_v4(signed_error_cleard)             : dc에 합성할때 signed error를 해결한 버전
        
        -inplace_fft_dif_dpsram_r2_1stage_temp      : 255까지 count하는 버전 이버전이후 출력이 나옴
        -inplace_fft_dif_dpsram_r2_1stage_compact   : cnt를 줄인 버전

        
    과정
        mb_fft -> mb_fft_v2 -> mb_fft_v3         -> mb_fft_v4 -> inplace_fft_dif_dpsram_r2_1stage_temp -> inplace_fft_dif_dpsram_r2_1stage_compact
                            -> mb_fft_v3_sat (x)

#파일

    inplace_fft_dif_dpsram_r2_1stage
        └─Inplace_FFT.v                  : tob block
            ├─simple_dualport_RAM        : dual-port sram을 간단히 modeling한 module
            └─Inplace_FFT_core           : memory를 제외한 inplace 동작을 하는 block
                ├─controlblock           : control 신호를 생성하는 block
                │    └─counter           : control 신호를 생성하기위해 count하는 block
                ├─BF                     : butterfly block
                ├─MULT_GEN               : cnt값에따하 twiddle factor를 곱하는 block
                └─SWAP                   : enable이 high일 때 입력의 순서를 바꾸는 block

    inplace_fft_dif_dpsram_r2_2stage,  inplace_fft_dif_dpsram_r2_3stage
        └─Inplace_FFT.v                  : tob block
            ├─simple_dualport_RAM        : dual-port sram을 간단히 modeling한 module
            └─Inplace_FFT_core           : memory를 제외한 inplace 동작을 하는 block
                ├─controlblock           : control 신호를 생성하는 block
                │    └─counter           : control 신호를 생성하기위해 count하는 block
                ├─BF                     : butterfly block
                ├─MULT_GEN               : cnt값에따하 twiddle factor를 곱하는 block
                ├─SWAP                   : enable이 high일 때 입력의 순서를 바꾸는 block
                └─pipelien_reg           : pipeline을 삽입하기위한 register block

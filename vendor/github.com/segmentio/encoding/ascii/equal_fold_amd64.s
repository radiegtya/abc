// Code generated by command: go run equal_fold_asm.go -out equal_fold_amd64.s -stubs equal_fold_amd64.go. DO NOT EDIT.

#include "textflag.h"

// func equalFoldAVX2(a *byte, b *byte, n uintptr) int
// Requires: AVX, AVX2, SSE4.1
TEXT ·equalFoldAVX2(SB), NOSPLIT, $0-32
	MOVQ         a+0(FP), CX
	MOVQ         b+8(FP), DX
	MOVQ         n+16(FP), BX
	XORQ         AX, AX
	SHRQ         $0x04, BX
	XORQ         SI, SI
	MOVB         $0x20, DI
	PINSRB       $0x00, DI, X6
	VPBROADCASTB X6, Y6
	MOVB         $0x1f, DI
	PINSRB       $0x00, DI, X7
	VPBROADCASTB X7, Y7
	MOVB         $0x9a, DI
	PINSRB       $0x00, DI, X8
	VPBROADCASTB X8, Y8
	MOVB         $0x01, DI
	PINSRB       $0x00, DI, X9
	VPBROADCASTB X9, Y9

loop64:
	CMPQ      BX, $0x04
	JB        cmp32
	VMOVDQU   (CX)(AX*1), Y0
	VMOVDQU   32(CX)(AX*1), Y3
	VMOVDQU   (DX)(AX*1), Y1
	VMOVDQU   32(DX)(AX*1), Y4
	VXORPD    Y0, Y1, Y1
	VPCMPEQB  Y6, Y1, Y2
	VORPD     Y6, Y0, Y0
	VPADDB    Y7, Y0, Y0
	VPCMPGTB  Y0, Y8, Y0
	VPAND     Y2, Y0, Y0
	VPAND     Y9, Y0, Y0
	VPSLLW    $0x05, Y0, Y0
	VPCMPEQB  Y1, Y0, Y0
	VXORPD    Y3, Y4, Y4
	VPCMPEQB  Y6, Y4, Y5
	VORPD     Y6, Y3, Y3
	VPADDB    Y7, Y3, Y3
	VPCMPGTB  Y3, Y8, Y3
	VPAND     Y5, Y3, Y3
	VPAND     Y9, Y3, Y3
	VPSLLW    $0x05, Y3, Y3
	VPCMPEQB  Y4, Y3, Y3
	VPAND     Y3, Y0, Y0
	ADDQ      $0x40, AX
	SUBQ      $0x04, BX
	VPMOVMSKB Y0, DI
	CMPL      DI, $0xffffffff
	JNE       done
	JMP       loop64

cmp32:
	CMPQ      BX, $0x02
	JB        cmp16
	VMOVDQU   (CX)(AX*1), Y0
	VMOVDQU   (DX)(AX*1), Y1
	VXORPD    Y0, Y1, Y1
	VPCMPEQB  Y6, Y1, Y2
	VORPD     Y6, Y0, Y0
	VPADDB    Y7, Y0, Y0
	VPCMPGTB  Y0, Y8, Y0
	VPAND     Y2, Y0, Y0
	VPAND     Y9, Y0, Y0
	VPSLLW    $0x05, Y0, Y0
	VPCMPEQB  Y1, Y0, Y0
	ADDQ      $0x20, AX
	SUBQ      $0x02, BX
	VPMOVMSKB Y0, DI
	CMPL      DI, $0xffffffff
	JNE       done

cmp16:
	CMPQ      BX, $0x01
	JB        equal
	VMOVDQU   (CX)(AX*1), X0
	VMOVDQU   (DX)(AX*1), X1
	VXORPD    X0, X1, X1
	VPCMPEQB  X6, X1, X2
	VORPD     X6, X0, X0
	VPADDB    X7, X0, X0
	VPCMPGTB  X0, X8, X0
	VPAND     X2, X0, X0
	VPAND     X9, X0, X0
	VPSLLW    $0x05, X0, X0
	VPCMPEQB  X1, X0, X0
	VPMOVMSKB X0, DI
	CMPL      DI, $0x0000ffff
	JNE       done

equal:
	MOVQ $0x0000000000000001, SI

done:
	MOVQ SI, ret+24(FP)
	RET

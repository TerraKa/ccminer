#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ < 300
/**
 * __shfl() returns the value of var held by the thread whose ID is given by srcLane.
 * If srcLane is outside the range 0..width-1, the thread's own value of var is returned.
 */
#undef __shfl
#define __shfl(var, srcLane, width) (uint32_t)(var)
#endif

#ifdef __CUDA_ARCH__

__device__ __forceinline__
void to_bitslice_quad(uint32_t * __restrict__ input, uint32_t * __restrict__ output)
{
    uint32_t other[8];
    const int n = threadIdx.x % 4;

    #pragma unroll
    for (int i = 0; i < 8; i++) {
        input[i] = __shfl((int)input[i], n ^ (3*(n >=1 && n <=2)), 4);
        other[i] = __shfl((int)input[i], (threadIdx.x + 1) % 4, 4);
        input[i] = __shfl((int)input[i], threadIdx.x & 2, 4);
        other[i] = __shfl((int)other[i], threadIdx.x & 2, 4);
        if (threadIdx.x & 1) {
            input[i] = __byte_perm(input[i], 0, 0x1032);
            other[i] = __byte_perm(other[i], 0, 0x1032);
        }
    }

    output[ 0] =  (input[ 0] & 0x00000001);
    output[ 0] |= ((other[ 0] & 0x00000001) << 1);
    output[ 0] |= ((input[ 1] & 0x00000001) << 2);
    output[ 0] |= ((other[ 1] & 0x00000001) << 3);
    output[ 0] |= ((input[ 2] & 0x00000001) << 4);
    output[ 0] |= ((other[ 2] & 0x00000001) << 5);
    output[ 0] |= ((input[ 3] & 0x00000001) << 6);
    output[ 0] |= ((other[ 3] & 0x00000001) << 7);
    output[ 0] |= ((input[ 4] & 0x00000001) << 8);
    output[ 0] |= ((other[ 4] & 0x00000001) << 9);
    output[ 0] |= ((input[ 5] & 0x00000001) <<10);
    output[ 0] |= ((other[ 5] & 0x00000001) <<11);
    output[ 0] |= ((input[ 6] & 0x00000001) <<12);
    output[ 0] |= ((other[ 6] & 0x00000001) <<13);
    output[ 0] |= ((input[ 7] & 0x00000001) <<14);
    output[ 0] |= ((other[ 7] & 0x00000001) <<15);
    output[ 0] |= ((input[ 0] & 0x00000100) << 8);
    output[ 0] |= ((other[ 0] & 0x00000100) << 9);
    output[ 0] |= ((input[ 1] & 0x00000100) <<10);
    output[ 0] |= ((other[ 1] & 0x00000100) <<11);
    output[ 0] |= ((input[ 2] & 0x00000100) <<12);
    output[ 0] |= ((other[ 2] & 0x00000100) <<13);
    output[ 0] |= ((input[ 3] & 0x00000100) <<14);
    output[ 0] |= ((other[ 3] & 0x00000100) <<15);
    output[ 0] |= ((input[ 4] & 0x00000100) <<16);
    output[ 0] |= ((other[ 4] & 0x00000100) <<17);
    output[ 0] |= ((input[ 5] & 0x00000100) <<18);
    output[ 0] |= ((other[ 5] & 0x00000100) <<19);
    output[ 0] |= ((input[ 6] & 0x00000100) <<20);
    output[ 0] |= ((other[ 6] & 0x00000100) <<21);
    output[ 0] |= ((input[ 7] & 0x00000100) <<22);
    output[ 0] |= ((other[ 7] & 0x00000100) <<23);

    output[ 1] = ((input[ 0] & 0x00000002) >> 1);
    output[ 1] |=  (other[ 0] & 0x00000002);
    output[ 1] |= ((input[ 1] & 0x00000002) << 1);
    output[ 1] |= ((other[ 1] & 0x00000002) << 2);
    output[ 1] |= ((input[ 2] & 0x00000002) << 3);
    output[ 1] |= ((other[ 2] & 0x00000002) << 4);
    output[ 1] |= ((input[ 3] & 0x00000002) << 5);
    output[ 1] |= ((other[ 3] & 0x00000002) << 6);
    output[ 1] |= ((input[ 4] & 0x00000002) << 7);
    output[ 1] |= ((other[ 4] & 0x00000002) << 8);
    output[ 1] |= ((input[ 5] & 0x00000002) << 9);
    output[ 1] |= ((other[ 5] & 0x00000002) <<10);
    output[ 1] |= ((input[ 6] & 0x00000002) <<11);
    output[ 1] |= ((other[ 6] & 0x00000002) <<12);
    output[ 1] |= ((input[ 7] & 0x00000002) <<13);
    output[ 1] |= ((other[ 7] & 0x00000002) <<14);
    output[ 1] |= ((input[ 0] & 0x00000200) << 7);
    output[ 1] |= ((other[ 0] & 0x00000200) << 8);
    output[ 1] |= ((input[ 1] & 0x00000200) << 9);
    output[ 1] |= ((other[ 1] & 0x00000200) <<10);
    output[ 1] |= ((input[ 2] & 0x00000200) <<11);
    output[ 1] |= ((other[ 2] & 0x00000200) <<12);
    output[ 1] |= ((input[ 3] & 0x00000200) <<13);
    output[ 1] |= ((other[ 3] & 0x00000200) <<14);
    output[ 1] |= ((input[ 4] & 0x00000200) <<15);
    output[ 1] |= ((other[ 4] & 0x00000200) <<16);
    output[ 1] |= ((input[ 5] & 0x00000200) <<17);
    output[ 1] |= ((other[ 5] & 0x00000200) <<18);
    output[ 1] |= ((input[ 6] & 0x00000200) <<19);
    output[ 1] |= ((other[ 6] & 0x00000200) <<20);
    output[ 1] |= ((input[ 7] & 0x00000200) <<21);
    output[ 1] |= ((other[ 7] & 0x00000200) <<22);

    output[ 2] = ((input[ 0] & 0x00000004) >> 2);
    output[ 2] |= ((other[ 0] & 0x00000004) >> 1);
    output[ 2] |=  (input[ 1] & 0x00000004);
    output[ 2] |= ((other[ 1] & 0x00000004) << 1);
    output[ 2] |= ((input[ 2] & 0x00000004) << 2);
    output[ 2] |= ((other[ 2] & 0x00000004) << 3);
    output[ 2] |= ((input[ 3] & 0x00000004) << 4);
    output[ 2] |= ((other[ 3] & 0x00000004) << 5);
    output[ 2] |= ((input[ 4] & 0x00000004) << 6);
    output[ 2] |= ((other[ 4] & 0x00000004) << 7);
    output[ 2] |= ((input[ 5] & 0x00000004) << 8);
    output[ 2] |= ((other[ 5] & 0x00000004) << 9);
    output[ 2] |= ((input[ 6] & 0x00000004) <<10);
    output[ 2] |= ((other[ 6] & 0x00000004) <<11);
    output[ 2] |= ((input[ 7] & 0x00000004) <<12);
    output[ 2] |= ((other[ 7] & 0x00000004) <<13);
    output[ 2] |= ((input[ 0] & 0x00000400) << 6);
    output[ 2] |= ((other[ 0] & 0x00000400) << 7);
    output[ 2] |= ((input[ 1] & 0x00000400) << 8);
    output[ 2] |= ((other[ 1] & 0x00000400) << 9);
    output[ 2] |= ((input[ 2] & 0x00000400) <<10);
    output[ 2] |= ((other[ 2] & 0x00000400) <<11);
    output[ 2] |= ((input[ 3] & 0x00000400) <<12);
    output[ 2] |= ((other[ 3] & 0x00000400) <<13);
    output[ 2] |= ((input[ 4] & 0x00000400) <<14);
    output[ 2] |= ((other[ 4] & 0x00000400) <<15);
    output[ 2] |= ((input[ 5] & 0x00000400) <<16);
    output[ 2] |= ((other[ 5] & 0x00000400) <<17);
    output[ 2] |= ((input[ 6] & 0x00000400) <<18);
    output[ 2] |= ((other[ 6] & 0x00000400) <<19);
    output[ 2] |= ((input[ 7] & 0x00000400) <<20);
    output[ 2] |= ((other[ 7] & 0x00000400) <<21);

    output[ 3] = ((input[ 0] & 0x00000008) >> 3);
    output[ 3] |= ((other[ 0] & 0x00000008) >> 2);
    output[ 3] |= ((input[ 1] & 0x00000008) >> 1);
    output[ 3] |=  (other[ 1] & 0x00000008);
    output[ 3] |= ((input[ 2] & 0x00000008) << 1);
    output[ 3] |= ((other[ 2] & 0x00000008) << 2);
    output[ 3] |= ((input[ 3] & 0x00000008) << 3);
    output[ 3] |= ((other[ 3] & 0x00000008) << 4);
    output[ 3] |= ((input[ 4] & 0x00000008) << 5);
    output[ 3] |= ((other[ 4] & 0x00000008) << 6);
    output[ 3] |= ((input[ 5] & 0x00000008) << 7);
    output[ 3] |= ((other[ 5] & 0x00000008) << 8);
    output[ 3] |= ((input[ 6] & 0x00000008) << 9);
    output[ 3] |= ((other[ 6] & 0x00000008) <<10);
    output[ 3] |= ((input[ 7] & 0x00000008) <<11);
    output[ 3] |= ((other[ 7] & 0x00000008) <<12);
    output[ 3] |= ((input[ 0] & 0x00000800) << 5);
    output[ 3] |= ((other[ 0] & 0x00000800) << 6);
    output[ 3] |= ((input[ 1] & 0x00000800) << 7);
    output[ 3] |= ((other[ 1] & 0x00000800) << 8);
    output[ 3] |= ((input[ 2] & 0x00000800) << 9);
    output[ 3] |= ((other[ 2] & 0x00000800) <<10);
    output[ 3] |= ((input[ 3] & 0x00000800) <<11);
    output[ 3] |= ((other[ 3] & 0x00000800) <<12);
    output[ 3] |= ((input[ 4] & 0x00000800) <<13);
    output[ 3] |= ((other[ 4] & 0x00000800) <<14);
    output[ 3] |= ((input[ 5] & 0x00000800) <<15);
    output[ 3] |= ((other[ 5] & 0x00000800) <<16);
    output[ 3] |= ((input[ 6] & 0x00000800) <<17);
    output[ 3] |= ((other[ 6] & 0x00000800) <<18);
    output[ 3] |= ((input[ 7] & 0x00000800) <<19);
    output[ 3] |= ((other[ 7] & 0x00000800) <<20);

    output[ 4] = ((input[ 0] & 0x00000010) >> 4);
    output[ 4] |= ((other[ 0] & 0x00000010) >> 3);
    output[ 4] |= ((input[ 1] & 0x00000010) >> 2);
    output[ 4] |= ((other[ 1] & 0x00000010) >> 1);
    output[ 4] |=  (input[ 2] & 0x00000010);
    output[ 4] |= ((other[ 2] & 0x00000010) << 1);
    output[ 4] |= ((input[ 3] & 0x00000010) << 2);
    output[ 4] |= ((other[ 3] & 0x00000010) << 3);
    output[ 4] |= ((input[ 4] & 0x00000010) << 4);
    output[ 4] |= ((other[ 4] & 0x00000010) << 5);
    output[ 4] |= ((input[ 5] & 0x00000010) << 6);
    output[ 4] |= ((other[ 5] & 0x00000010) << 7);
    output[ 4] |= ((input[ 6] & 0x00000010) << 8);
    output[ 4] |= ((other[ 6] & 0x00000010) << 9);
    output[ 4] |= ((input[ 7] & 0x00000010) <<10);
    output[ 4] |= ((other[ 7] & 0x00000010) <<11);
    output[ 4] |= ((input[ 0] & 0x00001000) << 4);
    output[ 4] |= ((other[ 0] & 0x00001000) << 5);
    output[ 4] |= ((input[ 1] & 0x00001000) << 6);
    output[ 4] |= ((other[ 1] & 0x00001000) << 7);
    output[ 4] |= ((input[ 2] & 0x00001000) << 8);
    output[ 4] |= ((other[ 2] & 0x00001000) << 9);
    output[ 4] |= ((input[ 3] & 0x00001000) <<10);
    output[ 4] |= ((other[ 3] & 0x00001000) <<11);
    output[ 4] |= ((input[ 4] & 0x00001000) <<12);
    output[ 4] |= ((other[ 4] & 0x00001000) <<13);
    output[ 4] |= ((input[ 5] & 0x00001000) <<14);
    output[ 4] |= ((other[ 5] & 0x00001000) <<15);
    output[ 4] |= ((input[ 6] & 0x00001000) <<16);
    output[ 4] |= ((other[ 6] & 0x00001000) <<17);
    output[ 4] |= ((input[ 7] & 0x00001000) <<18);
    output[ 4] |= ((other[ 7] & 0x00001000) <<19);

    output[ 5] = ((input[ 0] & 0x00000020) >> 5);
    output[ 5] |= ((other[ 0] & 0x00000020) >> 4);
    output[ 5] |= ((input[ 1] & 0x00000020) >> 3);
    output[ 5] |= ((other[ 1] & 0x00000020) >> 2);
    output[ 5] |= ((input[ 2] & 0x00000020) >> 1);
    output[ 5] |=  (other[ 2] & 0x00000020);
    output[ 5] |= ((input[ 3] & 0x00000020) << 1);
    output[ 5] |= ((other[ 3] & 0x00000020) << 2);
    output[ 5] |= ((input[ 4] & 0x00000020) << 3);
    output[ 5] |= ((other[ 4] & 0x00000020) << 4);
    output[ 5] |= ((input[ 5] & 0x00000020) << 5);
    output[ 5] |= ((other[ 5] & 0x00000020) << 6);
    output[ 5] |= ((input[ 6] & 0x00000020) << 7);
    output[ 5] |= ((other[ 6] & 0x00000020) << 8);
    output[ 5] |= ((input[ 7] & 0x00000020) << 9);
    output[ 5] |= ((other[ 7] & 0x00000020) <<10);
    output[ 5] |= ((input[ 0] & 0x00002000) << 3);
    output[ 5] |= ((other[ 0] & 0x00002000) << 4);
    output[ 5] |= ((input[ 1] & 0x00002000) << 5);
    output[ 5] |= ((other[ 1] & 0x00002000) << 6);
    output[ 5] |= ((input[ 2] & 0x00002000) << 7);
    output[ 5] |= ((other[ 2] & 0x00002000) << 8);
    output[ 5] |= ((input[ 3] & 0x00002000) << 9);
    output[ 5] |= ((other[ 3] & 0x00002000) <<10);
    output[ 5] |= ((input[ 4] & 0x00002000) <<11);
    output[ 5] |= ((other[ 4] & 0x00002000) <<12);
    output[ 5] |= ((input[ 5] & 0x00002000) <<13);
    output[ 5] |= ((other[ 5] & 0x00002000) <<14);
    output[ 5] |= ((input[ 6] & 0x00002000) <<15);
    output[ 5] |= ((other[ 6] & 0x00002000) <<16);
    output[ 5] |= ((input[ 7] & 0x00002000) <<17);
    output[ 5] |= ((other[ 7] & 0x00002000) <<18);

    output[ 6] = ((input[ 0] & 0x00000040) >> 6);
    output[ 6] |= ((other[ 0] & 0x00000040) >> 5);
    output[ 6] |= ((input[ 1] & 0x00000040) >> 4);
    output[ 6] |= ((other[ 1] & 0x00000040) >> 3);
    output[ 6] |= ((input[ 2] & 0x00000040) >> 2);
    output[ 6] |= ((other[ 2] & 0x00000040) >> 1);
    output[ 6] |=  (input[ 3] & 0x00000040);
    output[ 6] |= ((other[ 3] & 0x00000040) << 1);
    output[ 6] |= ((input[ 4] & 0x00000040) << 2);
    output[ 6] |= ((other[ 4] & 0x00000040) << 3);
    output[ 6] |= ((input[ 5] & 0x00000040) << 4);
    output[ 6] |= ((other[ 5] & 0x00000040) << 5);
    output[ 6] |= ((input[ 6] & 0x00000040) << 6);
    output[ 6] |= ((other[ 6] & 0x00000040) << 7);
    output[ 6] |= ((input[ 7] & 0x00000040) << 8);
    output[ 6] |= ((other[ 7] & 0x00000040) << 9);
    output[ 6] |= ((input[ 0] & 0x00004000) << 2);
    output[ 6] |= ((other[ 0] & 0x00004000) << 3);
    output[ 6] |= ((input[ 1] & 0x00004000) << 4);
    output[ 6] |= ((other[ 1] & 0x00004000) << 5);
    output[ 6] |= ((input[ 2] & 0x00004000) << 6);
    output[ 6] |= ((other[ 2] & 0x00004000) << 7);
    output[ 6] |= ((input[ 3] & 0x00004000) << 8);
    output[ 6] |= ((other[ 3] & 0x00004000) << 9);
    output[ 6] |= ((input[ 4] & 0x00004000) <<10);
    output[ 6] |= ((other[ 4] & 0x00004000) <<11);
    output[ 6] |= ((input[ 5] & 0x00004000) <<12);
    output[ 6] |= ((other[ 5] & 0x00004000) <<13);
    output[ 6] |= ((input[ 6] & 0x00004000) <<14);
    output[ 6] |= ((other[ 6] & 0x00004000) <<15);
    output[ 6] |= ((input[ 7] & 0x00004000) <<16);
    output[ 6] |= ((other[ 7] & 0x00004000) <<17);

    output[ 7] = ((input[ 0] & 0x00000080) >> 7);
    output[ 7] |= ((other[ 0] & 0x00000080) >> 6);
    output[ 7] |= ((input[ 1] & 0x00000080) >> 5);
    output[ 7] |= ((other[ 1] & 0x00000080) >> 4);
    output[ 7] |= ((input[ 2] & 0x00000080) >> 3);
    output[ 7] |= ((other[ 2] & 0x00000080) >> 2);
    output[ 7] |= ((input[ 3] & 0x00000080) >> 1);
    output[ 7] |=  (other[ 3] & 0x00000080);
    output[ 7] |= ((input[ 4] & 0x00000080) << 1);
    output[ 7] |= ((other[ 4] & 0x00000080) << 2);
    output[ 7] |= ((input[ 5] & 0x00000080) << 3);
    output[ 7] |= ((other[ 5] & 0x00000080) << 4);
    output[ 7] |= ((input[ 6] & 0x00000080) << 5);
    output[ 7] |= ((other[ 6] & 0x00000080) << 6);
    output[ 7] |= ((input[ 7] & 0x00000080) << 7);
    output[ 7] |= ((other[ 7] & 0x00000080) << 8);
    output[ 7] |= ((input[ 0] & 0x00008000) << 1);
    output[ 7] |= ((other[ 0] & 0x00008000) << 2);
    output[ 7] |= ((input[ 1] & 0x00008000) << 3);
    output[ 7] |= ((other[ 1] & 0x00008000) << 4);
    output[ 7] |= ((input[ 2] & 0x00008000) << 5);
    output[ 7] |= ((other[ 2] & 0x00008000) << 6);
    output[ 7] |= ((input[ 3] & 0x00008000) << 7);
    output[ 7] |= ((other[ 3] & 0x00008000) << 8);
    output[ 7] |= ((input[ 4] & 0x00008000) << 9);
    output[ 7] |= ((other[ 4] & 0x00008000) <<10);
    output[ 7] |= ((input[ 5] & 0x00008000) <<11);
    output[ 7] |= ((other[ 5] & 0x00008000) <<12);
    output[ 7] |= ((input[ 6] & 0x00008000) <<13);
    output[ 7] |= ((other[ 6] & 0x00008000) <<14);
    output[ 7] |= ((input[ 7] & 0x00008000) <<15);
    output[ 7] |= ((other[ 7] & 0x00008000) <<16);
}

__device__ __forceinline__
void from_bitslice_quad(uint32_t * __restrict__ input, uint32_t * __restrict__ output)
{
    output[ 0] = ((input[ 0] & 0x00000100) >> 8);
    output[ 0] |= ((input[ 1] & 0x00000100) >> 7);
    output[ 0] |= ((input[ 2] & 0x00000100) >> 6);
    output[ 0] |= ((input[ 3] & 0x00000100) >> 5);
    output[ 0] |= ((input[ 4] & 0x00000100) >> 4);
    output[ 0] |= ((input[ 5] & 0x00000100) >> 3);
    output[ 0] |= ((input[ 6] & 0x00000100) >> 2);
    output[ 0] |= ((input[ 7] & 0x00000100) >> 1);
    output[ 0] |= ((input[ 0] & 0x01000000) >>16);
    output[ 0] |= ((input[ 1] & 0x01000000) >>15);
    output[ 0] |= ((input[ 2] & 0x01000000) >>14);
    output[ 0] |= ((input[ 3] & 0x01000000) >>13);
    output[ 0] |= ((input[ 4] & 0x01000000) >>12);
    output[ 0] |= ((input[ 5] & 0x01000000) >>11);
    output[ 0] |= ((input[ 6] & 0x01000000) >>10);
    output[ 0] |= ((input[ 7] & 0x01000000) >> 9);
    output[ 2] = ((input[ 0] & 0x00000200) >> 9);
    output[ 2] |= ((input[ 1] & 0x00000200) >> 8);
    output[ 2] |= ((input[ 2] & 0x00000200) >> 7);
    output[ 2] |= ((input[ 3] & 0x00000200) >> 6);
    output[ 2] |= ((input[ 4] & 0x00000200) >> 5);
    output[ 2] |= ((input[ 5] & 0x00000200) >> 4);
    output[ 2] |= ((input[ 6] & 0x00000200) >> 3);
    output[ 2] |= ((input[ 7] & 0x00000200) >> 2);
    output[ 2] |= ((input[ 0] & 0x02000000) >>17);
    output[ 2] |= ((input[ 1] & 0x02000000) >>16);
    output[ 2] |= ((input[ 2] & 0x02000000) >>15);
    output[ 2] |= ((input[ 3] & 0x02000000) >>14);
    output[ 2] |= ((input[ 4] & 0x02000000) >>13);
    output[ 2] |= ((input[ 5] & 0x02000000) >>12);
    output[ 2] |= ((input[ 6] & 0x02000000) >>11);
    output[ 2] |= ((input[ 7] & 0x02000000) >>10);
    output[ 4] = ((input[ 0] & 0x00000400) >>10);
    output[ 4] |= ((input[ 1] & 0x00000400) >> 9);
    output[ 4] |= ((input[ 2] & 0x00000400) >> 8);
    output[ 4] |= ((input[ 3] & 0x00000400) >> 7);
    output[ 4] |= ((input[ 4] & 0x00000400) >> 6);
    output[ 4] |= ((input[ 5] & 0x00000400) >> 5);
    output[ 4] |= ((input[ 6] & 0x00000400) >> 4);
    output[ 4] |= ((input[ 7] & 0x00000400) >> 3);
    output[ 4] |= ((input[ 0] & 0x04000000) >>18);
    output[ 4] |= ((input[ 1] & 0x04000000) >>17);
    output[ 4] |= ((input[ 2] & 0x04000000) >>16);
    output[ 4] |= ((input[ 3] & 0x04000000) >>15);
    output[ 4] |= ((input[ 4] & 0x04000000) >>14);
    output[ 4] |= ((input[ 5] & 0x04000000) >>13);
    output[ 4] |= ((input[ 6] & 0x04000000) >>12);
    output[ 4] |= ((input[ 7] & 0x04000000) >>11);
    output[ 6] = ((input[ 0] & 0x00000800) >>11);
    output[ 6] |= ((input[ 1] & 0x00000800) >>10);
    output[ 6] |= ((input[ 2] & 0x00000800) >> 9);
    output[ 6] |= ((input[ 3] & 0x00000800) >> 8);
    output[ 6] |= ((input[ 4] & 0x00000800) >> 7);
    output[ 6] |= ((input[ 5] & 0x00000800) >> 6);
    output[ 6] |= ((input[ 6] & 0x00000800) >> 5);
    output[ 6] |= ((input[ 7] & 0x00000800) >> 4);
    output[ 6] |= ((input[ 0] & 0x08000000) >>19);
    output[ 6] |= ((input[ 1] & 0x08000000) >>18);
    output[ 6] |= ((input[ 2] & 0x08000000) >>17);
    output[ 6] |= ((input[ 3] & 0x08000000) >>16);
    output[ 6] |= ((input[ 4] & 0x08000000) >>15);
    output[ 6] |= ((input[ 5] & 0x08000000) >>14);
    output[ 6] |= ((input[ 6] & 0x08000000) >>13);
    output[ 6] |= ((input[ 7] & 0x08000000) >>12);
    output[ 8] = ((input[ 0] & 0x00001000) >>12);
    output[ 8] |= ((input[ 1] & 0x00001000) >>11);
    output[ 8] |= ((input[ 2] & 0x00001000) >>10);
    output[ 8] |= ((input[ 3] & 0x00001000) >> 9);
    output[ 8] |= ((input[ 4] & 0x00001000) >> 8);
    output[ 8] |= ((input[ 5] & 0x00001000) >> 7);
    output[ 8] |= ((input[ 6] & 0x00001000) >> 6);
    output[ 8] |= ((input[ 7] & 0x00001000) >> 5);
    output[ 8] |= ((input[ 0] & 0x10000000) >>20);
    output[ 8] |= ((input[ 1] & 0x10000000) >>19);
    output[ 8] |= ((input[ 2] & 0x10000000) >>18);
    output[ 8] |= ((input[ 3] & 0x10000000) >>17);
    output[ 8] |= ((input[ 4] & 0x10000000) >>16);
    output[ 8] |= ((input[ 5] & 0x10000000) >>15);
    output[ 8] |= ((input[ 6] & 0x10000000) >>14);
    output[ 8] |= ((input[ 7] & 0x10000000) >>13);
    output[10] = ((input[ 0] & 0x00002000) >>13);
    output[10] |= ((input[ 1] & 0x00002000) >>12);
    output[10] |= ((input[ 2] & 0x00002000) >>11);
    output[10] |= ((input[ 3] & 0x00002000) >>10);
    output[10] |= ((input[ 4] & 0x00002000) >> 9);
    output[10] |= ((input[ 5] & 0x00002000) >> 8);
    output[10] |= ((input[ 6] & 0x00002000) >> 7);
    output[10] |= ((input[ 7] & 0x00002000) >> 6);
    output[10] |= ((input[ 0] & 0x20000000) >>21);
    output[10] |= ((input[ 1] & 0x20000000) >>20);
    output[10] |= ((input[ 2] & 0x20000000) >>19);
    output[10] |= ((input[ 3] & 0x20000000) >>18);
    output[10] |= ((input[ 4] & 0x20000000) >>17);
    output[10] |= ((input[ 5] & 0x20000000) >>16);
    output[10] |= ((input[ 6] & 0x20000000) >>15);
    output[10] |= ((input[ 7] & 0x20000000) >>14);
    output[12] = ((input[ 0] & 0x00004000) >>14);
    output[12] |= ((input[ 1] & 0x00004000) >>13);
    output[12] |= ((input[ 2] & 0x00004000) >>12);
    output[12] |= ((input[ 3] & 0x00004000) >>11);
    output[12] |= ((input[ 4] & 0x00004000) >>10);
    output[12] |= ((input[ 5] & 0x00004000) >> 9);
    output[12] |= ((input[ 6] & 0x00004000) >> 8);
    output[12] |= ((input[ 7] & 0x00004000) >> 7);
    output[12] |= ((input[ 0] & 0x40000000) >>22);
    output[12] |= ((input[ 1] & 0x40000000) >>21);
    output[12] |= ((input[ 2] & 0x40000000) >>20);
    output[12] |= ((input[ 3] & 0x40000000) >>19);
    output[12] |= ((input[ 4] & 0x40000000) >>18);
    output[12] |= ((input[ 5] & 0x40000000) >>17);
    output[12] |= ((input[ 6] & 0x40000000) >>16);
    output[12] |= ((input[ 7] & 0x40000000) >>15);
    output[14] = ((input[ 0] & 0x00008000) >>15);
    output[14] |= ((input[ 1] & 0x00008000) >>14);
    output[14] |= ((input[ 2] & 0x00008000) >>13);
    output[14] |= ((input[ 3] & 0x00008000) >>12);
    output[14] |= ((input[ 4] & 0x00008000) >>11);
    output[14] |= ((input[ 5] & 0x00008000) >>10);
    output[14] |= ((input[ 6] & 0x00008000) >> 9);
    output[14] |= ((input[ 7] & 0x00008000) >> 8);
    output[14] |= ((input[ 0] & 0x80000000) >>23);
    output[14] |= ((input[ 1] & 0x80000000) >>22);
    output[14] |= ((input[ 2] & 0x80000000) >>21);
    output[14] |= ((input[ 3] & 0x80000000) >>20);
    output[14] |= ((input[ 4] & 0x80000000) >>19);
    output[14] |= ((input[ 5] & 0x80000000) >>18);
    output[14] |= ((input[ 6] & 0x80000000) >>17);
    output[14] |= ((input[ 7] & 0x80000000) >>16);

#pragma unroll 8
    for (int i = 0; i < 16; i+=2) {
        if (threadIdx.x & 1) output[i] = __byte_perm(output[i], 0, 0x1032);
        output[i] = __byte_perm(output[i], __shfl((int)output[i], (threadIdx.x+1)&3, 4), 0x7610);
        output[i+1] = __shfl((int)output[i], (threadIdx.x+2)&3, 4);
        if (threadIdx.x & 3) output[i] = output[i+1] = 0;
    }
}

#else

/* host "fake" functions */
#define from_bitslice_quad(st, out)
#define to_bitslice_quad(in, msg) in[0] = (uint32_t) in[0];

#endif /* device only code */

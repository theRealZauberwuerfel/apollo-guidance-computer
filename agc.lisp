(defstruct agc-word
  (parity 0 :type bit)
  (data (make-array 15 :element-type bit)
   :type (simple-bit-vector 15)))

(defstruct agc
  (frequency 2048
   :type (integer 0 2048)
   :read-only t)
  (ram (make-array 2048 :element-type agc-word)
   :type (vector agc-word 2048))
  (rom (make-array 36864 :element-type agc-word)
   :type (vector agc-word 36864)
   :read-only t)
  ;; accumulator register
  A
  ;; program counter - address of the next instruction to be executed
  (Z 0 :type (integer 0 36863))
  ;; remainder of the DV instruction, and the return address after TC instructions
  Q
  ;; lower product after MP instructions
  LP
  ;; 12-bit memory address register, the lower portion of the memory address
  (S (make-array 3 :element-type agc-word)
   :type (vector agc-word 3))
  ;; 4-bit ROM band register, to select the 1 kiloword ROM bank when addressing
  ;; in the fixed-switchable mode
  Bank/Fbank
  ;; 3-bit RAM bank register, to select the 256-word RAM bank when addressing
  ;; in the erasable-switchable mode
  Ebank
  ;; 1-bit extension to Fbank, required because the last 4 kilowords of the 36-kiloword
  ;; ROM was not reachable using Fbank alone
  ;; (super-bank)
  Sbank
  ;; 4-bit sequence register; the current instruction
  (SQ (make-agc-word) :type agc-word)
  ;; 16-bit memory buffer register, to hold data words moving to and from memory
  (G (make-array 4 :element-type 'agc-word)
   :type (vector agc-word 4))
  ;; The 'x' input to the adder
  X
  ;; the other ('y') input to the adder
  Y
  ;; not really a register, but the output of the adder
  ;; 1's complement sum of the contents of registers X and Y
  U
  ;; general-purpose buffer register
  B
  ;; not a separate register, but the 1's complement of the B register
  C
  ;; four 16-bit input registers
  (IN (make-array 4 :element-type agc-word)
   :type (vector agc-word 4))
  ;; four 16-bit output registers
  (OUT (make-array 4 :element-type agc-word)
   :type (vector agc-word 4)))

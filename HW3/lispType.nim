type
  myEnum = enum
    # How many bits for storing car/cdr kind:
    KIND_SIZE = 2,
    # How many bits for index into pool:
    LG2_POOLSIZE = 14

# Will be used for atoms:
type
  charArray = array[0..(1 shl ord(LG2_POOLSIZE)), char]
var atoms: charArray

type
  kind = enum
    NIL, STRING, INTEGER, CONS

type
  cons = object
    carKind {.bitsize:ord(KIND_SIZE).}: kind
    car {.bitsize:ord(LG2_POOLSIZE).}: cuint
    cdrKind {.bitsize:ord(KIND_SIZE).}: kind
    cdr {.bitsize:ord(LG2_POOLSIZE).}: cuint

# Pool of struct Cons nodes:
type
  poolArray = array[0..(1 shl ord(LG2_POOLSIZE)), cons]
var pool: poolArray

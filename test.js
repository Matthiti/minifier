/* 
This is a test file to be minimized
*/

// A test function
function test() {
  let a = 0
  let b = 2; let c = 3

  while (a < b) {
    a += 3
    b += 1
  }
  return b
}

console.log(test())
// The end of the function
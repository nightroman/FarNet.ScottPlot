
export function toDoubleArray(source) {
	let target = host.newArr(System.Double, source.length)
	source.forEach((value, index) => target[index] = value)
	return target
}

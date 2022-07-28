
/**
 * Converts JS array to .NET array.
 * @param {any} type - .NET type.
 * @param {any[]} source - JS array.
 * @returns .NET array.
 */
export function toArray(type, source) {
    let target = host.newArr(type, source.length)
    source.forEach((value, index) => target[index] = value)
    return target
}

export const signal = initialValue => {
  let value = initialValue
  let listeners = []

  const get = () => value

  const set = newValue => {
    value = newValue
    listeners.forEach(listener => listener(value))
  }

  const sub = listener => {
    listeners.push(listener)
    // return unsubscribe
    return () => listeners.indexOf(listener) !== -1 ? listeners.splice(listeners.indexOf(listener), 1) : null
  }

  return { get, set, sub }
}

export const list = (value, tag) => value.map((value, index) => `<${tag} data-key=${index}>${value}</${tag}>`).join('')
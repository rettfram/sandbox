export const loadFile = async url => {
  const fileType = url.split('.').pop().toLowerCase()

  if (['jpg', 'png', 'webp'].includes(fileType)) {
    return new Promise((resolve, reject) => {
      const img = new Image()
      img.src = url
      img.onload = () => resolve()
      img.onerror = reject
    })
  } else if (['mp4', 'webm'].includes(fileType)) {
    return new Promise((resolve, reject) => {
      const video = document.createElement('video')
      video.src = url
      video.onloadeddata = () => resolve()
      video.onerror = reject
    })
  } else {
    try {
      const response = await fetch(url)
      const blob = await response.blob()
      return blob
    } catch (error) {
      throw error
    }
  }
}

export const loadFiles = async urls => {
  try {
    await Promise.all(urls.map(url => loadFile(url)))
    return true
  } catch (error) {
    return false
  }
}
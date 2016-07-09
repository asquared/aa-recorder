# aa-recorder
Records RTSP streams from IP cameras to mp4 files. Automatically deletes files
when the disk gets full. No frills. Hopefully just works.

# Installation
Make sure ffmpeg, node, and npm are installed, then `npm install -g aa-recorder`.

# Usage
`aa-recorder yourConfig.json`

# Config file
The configuration is a JSON file. See the examples directory. 

## Top-level options
* `storageDir`: where to store the video files. Required.
* `cleanupThreshold`: Minimum amount of free disk space to maintain. The oldest files will be deleted from the `storageDir` when this is exceeded. Understands suffixes e.g. (MB, GB, k, m, g). Default 10GB.
* `cameras`: List of cameras, see below.

## Camera options
* `name`: Descriptive name for the camera. This is used to generate file names.
* `url`: The RTSP URL to use for recording. For AXIS cameras this is typically `rtsp://your-camera-ip-or-hostname/axis-media/media.amp`.
* `args`: Arguments to be added to the URL as a query string. Optional. These are passed through verbatim to the camera, so check your camera documentation for more info.
* `respawnThreshold`: Minimum amount of time the ffmpeg process should run for, in milliseconds. If the process runs for a shorter time, a delay is incurred before the process is restarted. Default 5 seconds.
* `respawnDelay`: The amount of time, in milliseconds, to wait before retrying if the `respawnThreshold` is not exceeded. Default 60 seconds.
* `fileType`: The file type to record to. Default `mp4`.

# Run as a daemon
No built-in facility is provided for running as a daemon; for my purposes it's
easier to run as a systemd service. An example unit file with installation
instructions is provided in the examples directory.

# License
MIT license. See LICENSE file.

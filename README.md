# aa-recorder
Records RTSP streams from IP cameras to mp4 files. Automatically deletes files
when the disk gets full. No frills. Hopefully just works.

# Installation
Make sure ffmpeg, node, and npm are installed, then `npm install -g aa-recorder`.

# Usage
`aa-recorder yourConfig.json`

# Config file
The configuration is a JSON file. See the examples directory.

# WARNING
This script automatically deletes files. The way it does so is currently very
dumb, and just munches the oldest files in the directory when space gets tight.
So don't point it at a directory containing anything you don't want it to
delete. It's also recommended not to run this script as root.

## Top-level options
* `storageDir`: where to store the video files. Required.
* `cleanupThreshold`: Minimum amount of free disk space to maintain. The oldest
  files will be deleted from the `storageDir` when this is exceeded. Understands
  suffixes e.g. (MB, GB, k, m, g). Default 10GB.
* `cameras`: List of cameras, see below.

## Camera options
* `name`: Descriptive name for the camera. This is used to generate file names.
* `url`: The RTSP URL to use for recording. For AXIS cameras this is typically
  `rtsp://your-camera-ip-or-hostname/axis-media/media.amp`. Use
  `rtsp://username:password@hostname-or-ip` if you need credentials
  (but see the known issues below!)
* `args`: Arguments to be added to the URL as a query string. Optional. These
  are passed through verbatim to the camera, so check your camera documentation
  for more info. It's important to specify a maximum duration to the camera,
  either in the URL or in the args; otherwise you'll end up with one big file.
* `respawnThreshold`: Minimum amount of time the ffmpeg process should run for,
  in milliseconds. If the process runs for a shorter time, a delay is incurred
  before the process is restarted. Default 5 seconds.
* `respawnDelay`: The amount of time, in milliseconds, to wait before retrying
  if the `respawnThreshold` is not exceeded. Default 60 seconds.
* `fileType`: The file type to record to. Default `mp4`.

# Run as a daemon
No built-in facility is provided for running as a daemon; for my purposes it's
easier to run as a systemd service. An example unit file with installation
instructions is provided in the examples directory.

# Known issues
Your camera credentials will show up in `ps aux`. Therefore, you should use limited
credentials (view-only on the camera) and/or run this on a machine where only trusted
folks have access. Fixing would require a patch to ffmpeg and/or a rewrite to
eliminate the ffmpeg dependency.

# License
MIT license. See LICENSE file.

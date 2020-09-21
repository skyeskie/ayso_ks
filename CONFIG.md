## Introduction
This is a scheduling application. Although it is primarily developed for AYSO regions in the Wichita, KS area, it can be adapted for other sports schedules.

## Assumptions / Model
There are several points to how the app is currently designed that are build-in to its model. If these do not work, they may require quite a bit of work to fix.
- Games are broken up into weeks
  - This can be flexible, as each is defined only by the week start.
  - The text could be changed to "Round", with the different starts put all on the same day.
  - Removing the week separation would require substantial changes
- Locations are split into street map and field map
- Teams have groupings on age and gender

*Note: if you run into others while adapting, please update* 

## Configuration
### `.env`
Several secrets needed to run the app are not stored in source code, for example Twitter access keys.

See `.env_required` for which values are needed

One option is to
1. Copy `.env_required` to `.env`
1. Fill in all the required values
    - Format is `KEY=VALUE`
    - No quotes
    - One per line
1. Run (on Windows) `gen_config.bat`, which
    1. Loads the secrets in `.env` as environment variables
    1. Runs `flutter pub run environment_config:generate`

TODO: Add Bash run, perhaps with https://github.com/madcoda/dotenv-shell

### `lib/data_config.dart`
This is the main configuration of the application.

### `lib/di_config.dart`
There are different implementations for some parts of the application.
- The data can be retrieved through an included file (`BackendJsonAsset`) or remotely (`BackendRemoteJson`).
- Data can be cached locally using local key-value stores, SQLite, or only using memory (and no persisted data).

### `lib/service/json_model.dart`
This is the main file reading in schedules data in JSON. There are a couple Wichita-specific parts build into the format. Primarily, all team names coded to indicate of the region, age group, and gender of the team

### Images
Images are stored in the `img` folder. Also, they'll need to be properly configured in `pubspec.yaml` (under assets at the end)

import * as core from '@actions/core'
import {
  default as finder,
  FallbackVersion
} from '@web-pacotes/flutter-version-finder'
import {existsSync, readFileSync} from 'fs'

async function run(): Promise<void> {
  try {
    let path = core.getInput('project-path')

    if (path.length === 0) {
      path = process.cwd()
    }

    core.info(`Finding supported Flutter version for project in path: ${path}`)

    const pubspecLockFile = `${path}/pubspec.lock`
    const pubspecYAMLFile = `${path}/pubspec.yaml`

    let yamlFilePath = pubspecLockFile
    let flutterVersion = FallbackVersion

    if (!existsSync(pubspecLockFile)) {
      core.info(`pubspec.lock doesn't exist, trying pubspec.yaml...`)

      yamlFilePath = pubspecYAMLFile

      if (!existsSync(pubspecYAMLFile)) {
        core.warning(
          `pubspec.yaml also doesn't exist, fallbacking to version: ${flutterVersion.flutter}`
        )

        return Promise.resolve()
      }
    }

    core.info(`using ${yamlFilePath} to get supported Flutter version...`)

    const yaml = readFileSync(yamlFilePath).toString()
    flutterVersion = finder(yaml)

    core.setOutput('flutter-version', flutterVersion.flutter)
  } catch (error) {
    if (error instanceof Error) core.setFailed(error.message)
  }
}

run()

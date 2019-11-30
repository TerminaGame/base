//
//  options.swift
//  termina-base
//
//  Created by Marquis Kurt on 11/1/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
// This is usually taken care of Info.plist, but this is a Unix
// executable, so these options are defined here. Azure DevOps
// builds will overwrite the build variable from here to the build
// being generated in the pipeline sequence.
//
import Foundation
import ColorizeSwift

let version = "1.0.0beta1"
let build = "beta1"
let fullBuildId = version + build
let copyright = "Copyright © 2018 Termina developers. All rights reserved."
let license = """
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

\("http://www.apache.org/licenses/LICENSE-2.0".cyan().underline())

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

\("ColorizeSwift".cyan()), \("Files".cyan()), and \("SwiftyJSON".cyan()) are included
and are licensed under their respective licenses.
"""

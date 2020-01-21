const _ = require('lodash')

const utils = {
  myFilter (targetJobs, badJobs, jobTitle) {
    let isBad = _.some(badJobs, (badJob) => {
      return jobTitle.toLowerCase().includes(badJob)
    })
    // if badJobs is empty, don't filter anything out
    if (_.isEmpty(badJobs)) {
      isBad = false
    }
    let isGood = _.some(targetJobs, (targetJob) => {
      return jobTitle.toLowerCase().includes(targetJob)
    })
    // if targetJobs is empty, don't filter anything out
    if (_.isEmpty(targetJobs)) {
      isGood = true
    }
    return !isBad && isGood
  },
  splitOnIndex (value, index) {
    const ret = []
    ret.push(value.substring(0, index))
    ret.push(value.substring(index))
    return ret
  }
}

module.exports = utils

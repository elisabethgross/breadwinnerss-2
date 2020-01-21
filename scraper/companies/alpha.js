const utils = require('../utils')
const _ = require('lodash')

class Alpha {
  constructor (targetJobs, badJobs, targetDepts, badDepts, url, baseUrl, companyName, companyUrl, type) {
    this.name = companyName
    this.companyURL = companyUrl
    this.type = type
    this.url = url
    this.targetElSelector = 'section.level-0'
    this.targetDepts = targetDepts || []
    this.badDepts = badDepts || []
    this.targetJobs = targetJobs || []
    this.badJobs = badJobs || []
  }
  filterDepts (data, $) {
    const that = this
    const deptJobs = data.filter(function () {
      const deptName = $(this).find('h3').text()
      return utils.myFilter(that.targetDepts, that.badDepts, deptName)
    })
    const ret = []
    deptJobs.each(function () {
      $(this).find('.opening').each(function () {
        const jobTitle = $(this).find('a').text()
        const location = $(this).find('span').text()
        const url = $(this).find('a').attr('href')
        ret.push({
          jobTitle,
          location,
          url
        })
      })
    })
    return ret
  }
  filterJobs (data) {
    const filteredJobs = _.filter(data, (job) => {
      const jobTitle = job.jobTitle
      return utils.myFilter(this.targetJobs, this.badJobs, jobTitle)
    })
    return filteredJobs
  }
  findJob ($) {
    const data = $(this.targetElSelector)
    const deptJobs = this.filterDepts(data, $)
    const jobs = this.filterJobs(deptJobs)
    return jobs
  }
}

module.exports = Alpha

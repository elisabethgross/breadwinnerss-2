
const utils = require('../utils')

class TenTenData {
  constructor (targetJobs, badJobs, targetDepts, badDepts, url, baseUrl, companyName, companyUrl, type) {
    this.name = companyName
    this.companyURL = companyUrl
    this.type = type
    this.url = url
    this.baseUrl = baseUrl
    this.targetElSelector = '.grid__block'
    this.targetDepts = targetDepts || []
    this.badDepts = badDepts || []
    this.targetJobs = targetJobs || []
    this.badJobs = badJobs || []
  }
  // noop for now
  filterDepts () {

  }
  filterJobs (data, $) {
    const ret = []
    data.each(function () {
      const that = this
      const children = $(this).children().filter('a')
      const filteredChildren = children.filter(function () {
        const jobTitle = $(this).text()
        return utils.myFilter(that.targetJobs, that.badJobs, jobTitle)
      })
      filteredChildren.each(function () {
        const jobTitle = $(this).text()
        const url = $(this).attr('href')
        const location = $(this).next().text()
        ret.push({
          jobTitle,
          location,
          url: that.baseUrl + url
        })
      })
    })
    return ret
  }
  findJob ($) {
    const jobEls = $(this.targetElSelector)
    const jobs = this.filterJobs(jobEls, $)
    return jobs
  }
}

module.exports = TenTenData

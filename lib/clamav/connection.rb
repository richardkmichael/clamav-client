# clamav-client - ClamAV client
# Copyright (C) 2014 Franck Verrot <franck@verrot.fr>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'socket'

module ClamAV
  class Connection
    def initialize(socket:, wrapper:)
      @socket = socket
      @wrapper = wrapper
    end

    def establish_connection
      wrapped_request = @wrapper.wrap_request("IDSESSION")
      @socket.write wrapped_request
    end

    def send_request(str)
      wrapped_request = @wrapper.wrap_request(str)
      @socket.write wrapped_request
      @wrapper.read_response(@socket)
    end
  end
end

// ======================================================================
// \title  ReferenceDeploymentTopologyDefs.hpp
// \brief  Required header for the topology autocoder. Pulls in every
//         subtopology PingEntries / TopologyDefs file and declares the
//         per-instance health-ping thresholds used by the deployment.
// ======================================================================
#ifndef ReferenceDeployment_ReferenceDeploymentTopologyDefs_HPP
#define ReferenceDeployment_ReferenceDeploymentTopologyDefs_HPP

#include "FprimeStressReference/ReferenceDeployment/Top/FppConstantsAc.hpp"

// Subtopology PingEntries includes
#include "Svc/Subtopologies/CdhCore/PingEntries.hpp"
#include "Svc/Subtopologies/ComCcsds/PingEntries.hpp"
#include "Svc/Subtopologies/FileHandling/PingEntries.hpp"
#include "Doom/DoomSubtopology/PingEntries.hpp"

// SubtopologyTopologyDefs includes
#include "Svc/Subtopologies/CdhCore/SubtopologyTopologyDefs.hpp"
#include "Svc/Subtopologies/ComCcsds/SubtopologyTopologyDefs.hpp"
#include "Svc/Subtopologies/FileHandling/SubtopologyTopologyDefs.hpp"
#include "Doom/DoomSubtopology/SubtopologyTopologyDefs.hpp"

// FPP constants from each subtopology config. Required because the
// outer topology autocoder inlines each subtopology's
// `phase configComponents` body into the deployment-level
// ReferenceDeploymentTopologyAc.cpp, where those config namespaces
// must already be visible.
#include "Svc/Subtopologies/CdhCore/CdhCoreConfig/FppConstantsAc.hpp"
#include "Svc/Subtopologies/ComCcsds/ComCcsdsConfig/FppConstantsAc.hpp"
#include "Svc/Subtopologies/FileHandling/FileHandlingConfig/FppConstantsAc.hpp"
#include "Doom/DoomConfig/FppConstantsAc.hpp"

// ComCcsds queue-port enums required by the inlined
// ComCcsds::Subtopology::configComponents body (which indexes the
// ComQueue configurationTable via Ports_ComPacketQueue and
// Ports_ComBufferQueue). Pulled in directly via the autocoded enum
// headers so the outer topology autocoder finds them in scope.
#include "Svc/Subtopologies/ComCcsds/Ports_ComPacketQueueEnumAc.hpp"
#include "Svc/Subtopologies/ComCcsds/Ports_ComBufferQueueEnumAc.hpp"

// Per-instance health-ping thresholds. The local active components in
// the deployment (rate groups and the command sequencer) need their
// PingEntries::<module>_<inst> stub declared so the topology autocoder
// can resolve them.
namespace PingEntries {
namespace ReferenceDeployment_rateGroup1Comp {
enum { WARN = 3, FATAL = 5 };
}
namespace ReferenceDeployment_rateGroup2Comp {
enum { WARN = 3, FATAL = 5 };
}
namespace ReferenceDeployment_rateGroup3Comp {
enum { WARN = 3, FATAL = 5 };
}
namespace ReferenceDeployment_cmdSeq {
enum { WARN = 3, FATAL = 5 };
}
}  // namespace PingEntries

namespace ReferenceDeployment {

//! Topology setup state. Wraps all the per-subtopology state pieces
//! plus the deployment-specific knobs (UDP comm and WAD path).
struct TopologyState {
    //! Remote (ground) IP the downlink datagrams are sent to.
    const char* hostname = nullptr;
    //! Remote UDP port receiving downlink (TM) datagrams.
    U16 port = 0;
    //! Local UDP port to listen on for uplink (TC) datagrams; 0
    //! binds an ephemeral port, effectively disabling uplink. Only
    //! used when comms are enabled via hostname/port. Defaults to the
    //! project convention shared with fprime-gds.yml and yamcs/etc.
    U16 uplinkPort = 50001;
    //! Path to the DOOM IWAD file that should be passed to the engine.
    //! Must reference an existing WAD: the engine rejects a Start
    //! with no configured path (auto-search is not permitted).
    const char* wadPath = nullptr;
    //! True if the engine should auto-start at topology setup time;
    //! false if the operator will dispatch the Start command manually.
    bool autoStart = false;
    CdhCore::SubtopologyState cdhCore;
    ComCcsds::SubtopologyState comCcsds;
    FileHandling::SubtopologyState fileHandling;
    DoomSubtopology::SubtopologyState doom;
};

namespace PingEntries = ::PingEntries;

}  // namespace ReferenceDeployment

#endif
